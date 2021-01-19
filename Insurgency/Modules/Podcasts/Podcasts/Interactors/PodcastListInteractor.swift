//
//  PodcastListInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import Foundation

// MARK: Initialization

enum PodcastListInteractor {
    struct Environment {
        let repository: PodcastRepositoryProtocol
        let scheduler: AnySchedulerOf<DispatchQueue>
        let episode: PodcastEpisodeListInteractor.Environment
    }

    struct State: Equatable {
        var status: Status = .initial
        var viewModels: PodcastListItemViewModels = []
        var selection: Identified<Int, PodcastEpisodeListInteractor.State>?

        var term: String {
            if case .search(let term) = status {
                return term
            } else {
                return ""
            }
        }
    }

    enum Status: Equatable {
        case initial
        case search(String)
        case result(Result<PodcastListItemViewModels, Failure>)
    }

    enum Action: Equatable {
        case search(String)
        case result(Result<PodcastListItemViewModels, Failure>)
        case episode(PodcastEpisodeListInteractor.Action)
        case navigation(selection: Int?)
    }
}

// MARK: Reducer

extension PodcastListInteractor {
    static func reducer() -> Reducer<State, Action, Environment> {
        PodcastEpisodeListInteractor.reducer()
            .pullback(
                state: \.value,
                action: .self,
                environment: { $0 }
            )
            .optional()
            .pullback(
                state: \.selection,
                action: /PodcastListInteractor.Action.episode,
                environment: { $0.episode }
            )
            .combined(with: .init { state, action, environment in
                struct UniqueID: Hashable {}

                switch action {
                case .search(let term):
                    if term.isEmpty {
                        state.status = .initial
                        return .cancel(id: UniqueID())
                    } else {
                        state.status = .search(term)
                        return environment.repository
                            .fetchPodcasts(with: term)
                            .map { $0.results.map(PodcastListItemViewModel.init) }
                            .catchToEffect()
                            .debounce(id: UniqueID(), for: 0.3, scheduler: environment.scheduler)
                            .map(Action.result)
                    }
                case .result(let result):
                    switch result {
                    case .success(let viewModels):
                        state.viewModels = viewModels
                    case .failure:
                        state.viewModels = []
                    }
                    state.status = .result(result)
                    return .none
                case let .navigation(selection: .some(id)):
                    if let viewModel = state.viewModels.first(where: { $0.id == id }) {
                        state.selection = Identified(.init(podcast: viewModel.podcast), id: id)
                    }
                    return .none
                case .navigation(selection: .none):
                    state.selection = nil
                    return .cancel(id: UniqueID())
                case .episode:
                    return .none
                }
            }
        )
    }
}
