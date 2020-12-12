//
//  PodcastEpisodeListViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

struct PodcastEpisodeListViewModel {
    struct Environment {
        let repository: PodcastEpisodeRepositoryProtocol
        let url: URL
        let queue: AnySchedulerOf<DispatchQueue>
    }

    enum Action: Equatable {
        case appear
        case result(Result<PodcastEpisodeListItemViewModels, Failure>)
    }

    enum State: Equatable {
        case loading
        case result(Result<PodcastEpisodeListItemViewModels, Failure>)
    }
}

// MARK: Reducer

extension PodcastEpisodeListViewModel {
    static func reducer() -> Reducer<State, Action, Environment> {
        Reducer<State, Action, Environment> { state, action, environment in
            switch action {
            case .appear:
                state = .loading
                return environment.repository
                    .fetchEpisodes(from: environment.url)
                    .map { $0.map(PodcastEpisodeListItemViewModel.init) }
                    .catchToEffect()
                    .map(Action.result)
            case .result(let result):
                state = .result(result)
                return .none
            }
        }
    }
}

// MARK: Store

extension PodcastEpisodeListViewModel {
    static func store(with enviroment: Environment) -> Store<State, Action> {
        Store(
            initialState: .loading,
            reducer: reducer().debug(),
            environment: enviroment
        )
    }
}
