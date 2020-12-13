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
        let podcast: Podcast
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
        .init { state, action, environment in
            switch action {
            case .appear:
                switch state {
                case .loading:
                    if let feedURL = environment.podcast.feedURL {
                        return environment.repository
                            .fetchEpisodes(from: feedURL)
                            .map { resuts in
                                resuts.map {
                                    PodcastEpisodeListItemViewModel(
                                        episode: $0,
                                        podcastArtworkURL: environment.podcast.artworkURL
                                    )
                                }
                            }
                            .catchToEffect()
                            .map(Action.result)
                    } else {
                        return .none
                    }
                case .result(let result):
                    state = .result(result)
                    return .none
                }
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
        .init(
            initialState: .loading,
            reducer: reducer().debug(),
            environment: enviroment
        )
    }
}
