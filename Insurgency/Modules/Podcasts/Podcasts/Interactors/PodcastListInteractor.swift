//
//  PodcastListInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

struct PodcastListInteractor {
    struct Environment {
        let repository: PodcastRepositoryProtocol
        let queue: AnySchedulerOf<DispatchQueue>
    }

    enum Action: Equatable {
        case search(String)
        case result(Result<PodcastListItemViewModels, Failure>)
    }

    enum State: Equatable {
        case initial
        case search(String)
        case result(Result<PodcastListItemViewModels, Failure>)

        var term: String {
            if case .search(let term) = self {
                return term
            } else {
                return ""
            }
        }
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
                        state = .initial
                        return .cancel(id: UniqueID())
                    } else {
                        state = .search(term)
                        return environment.repository
                            .fetchPodcasts(with: term)
                            .map { $0.results.map(PodcastListItemViewModel.init) }
                            .catchToEffect()
                            .debounce(id: UniqueID(), for: 0.3, scheduler: environment.queue)
                            .map(Action.result)
                    }
                case .result(let result):
                    state = .result(result)
                    return .none
                }
            }
        )
    }
}

// MARK: Store

extension PodcastListInteractor {
    static func store(with environment: Environment) -> Store<State, Action> {
        .init(
            initialState: .initial,
            reducer: reducer().debug(),
            environment: environment
        )
    }
}
