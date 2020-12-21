//
//  PodcastEpisodeListInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

enum PodcastEpisodeListInteractor {
    struct Environment {
        let repository: PodcastEpisodeRepositoryProtocol
        let podcast: Podcast
        let queue: AnySchedulerOf<DispatchQueue>
        let streamer: StreamerInteractor.Environment = .init(streamer: AudioStreamer())
    }

    struct State: Equatable {
        var status: Status = .loading
        var streamer: StreamerInteractor.State?
        var container: PodcastEpisodeContainer?
        var isSheetPresented: Bool { container != nil }
    }

    enum Status: Equatable {
        case loading
        case result(Result<PodcastEpisodeListItemViewModels, Failure>)
    }

    enum Action: Equatable {
        case appear
        case result(Result<PodcastEpisodeListItemViewModels, Failure>)
        case sheet(isPresented: Bool)
        case select(container: PodcastEpisodeContainer)
        case streamer(StreamerInteractor.Action)
    }
}

// MARK: Reducer

extension PodcastEpisodeListInteractor {
    static func reducer() -> Reducer<State, Action, Environment> {
        StreamerInteractor.reducer()
            .optional()
            .pullback(
                state: \.streamer,
                action: /PodcastEpisodeListInteractor.Action.streamer,
                environment: { $0.streamer }
            )
            .combined(with: .init { state, action, environment in
                switch action {
                case .streamer:
                    return .none
                case .select(let container):
                    state.container = container
                    state.streamer = .init(
                        isPlaying: false,
                        progress: 0.0,
                        duration: StreamerUpdateViewModel.kEmptyTimeField,
                        remaining: StreamerUpdateViewModel.kEmptyTimeField,
                        volume: 0.8,
                        artworkURL: container.episode.artworkURL ?? container.podcastArtworkURL,
                        mediaURL: container.episode.mediaURL,
                        title: container.episode.title,
                        subtitle: container.episode.subtitle
                    )
                    return .none
                case .sheet:
                    state.container = nil
                    return .none
                case .appear:
                    switch state.status {
                    case .loading:
                        return environment.repository
                            .fetchEpisodes(from: environment.podcast.feedURL)
                            .map { results in
                                results
                                    .map { episode in
                                        let container = PodcastEpisodeContainer(
                                            podcastArtworkURL: environment.podcast.artworkURL,
                                            episode: episode
                                        )
                                        return PodcastEpisodeListItemViewModel(container: container)
                                    }
                                }
                            .catchToEffect()
                            .map(Action.result)
                    case .result(let result):
                        state.status = .result(result)
                        return .none
                    }
                case .result(let result):
                    state.status = .result(result)
                    return .none
                }
            }
        )
    }
}

// MARK: Store

extension PodcastEpisodeListInteractor {
    static func store(with environment: Environment) -> Store<State, Action> {
        .init(
            initialState: .init(),
            reducer: reducer(),
            environment: environment
        )
    }
}
