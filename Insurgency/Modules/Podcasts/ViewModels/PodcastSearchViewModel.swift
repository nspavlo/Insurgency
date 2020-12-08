//
//  PodcastSearchViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

struct PodcastSearchViewModel {
    struct Environment {
        let repository: PodcastRepositoryProtocol
        let queue: AnySchedulerOf<DispatchQueue>
    }

    enum Action: Equatable {
        case appear
        case search(String)
        case result(Result<PodcastListItemViewModels, Failure>)
    }

    enum State: Equatable {
        case initial
        case search(String)
        case loading
        case result(Result<PodcastListItemViewModels, Failure>)

        var searchTerm: String {
            if case .search(let term) = self {
                return term
            } else {
                return ""
            }
        }
    }
}

// MARK:

extension PodcastSearchViewModel {
    static func reducer() -> Reducer<State, Action, Environment> {
        Reducer<State, Action, Environment> { state, action, environment in
            switch action {
            case .appear:
                return .none
            case .search(let term):
                struct UniquieID: Hashable {}

                state = .search(term)

                guard !term.isEmpty else {
                    return .cancel(id: UniquieID())
                }

                state = .loading

                return environment.repository
                    .fetchPodcasts(with: term)
                    .map { $0.results.map(PodcastListItemViewModel.init) }
                    .catchToEffect()
                    .debounce(id: UniquieID(), for: 0.3, scheduler: environment.queue)
                    .map(PodcastSearchViewModel.Action.result)
            case .result(let result):
                state = .result(result)
                return .none
            }
        }
    }
}
