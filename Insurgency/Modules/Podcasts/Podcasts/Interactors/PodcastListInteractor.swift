//
//  PodcastListInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

enum PodcastListInteractor {
    struct Environment {
        let repository: PodcastRepositoryProtocol
        let queue: AnySchedulerOf<DispatchQueue>
    }

    struct State: Equatable {
        var status: Status = .initial

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
    }
}

// MARK: Reducer

extension PodcastListInteractor {
    static func reducer() -> Reducer<State, Action, Environment> {
        .combine(
            .init { state, action, environment in
                switch action {
                case .search(let term):
                    struct UniqueID: Hashable {}

                    if term.isEmpty {
                        state.status = .initial
                        return .cancel(id: UniqueID())
                    } else {
                        state.status = .search(term)
                        return environment.repository
                            .fetchPodcasts(with: term)
                            .map { $0.results.map(PodcastListItemViewModel.init) }
                            .catchToEffect()
                            .debounce(id: UniqueID(), for: 0.3, scheduler: environment.queue)
                            .map(Action.result)
                    }
                case .result(let result):
                    state.status = .result(result)
                    return .none
                }
            }
        )
    }
}
