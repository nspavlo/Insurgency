//
//  PodcastEpisodeListInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import Foundation

// MARK: Initialization

enum PodcastEpisodeListInteractor {
    struct Environment {
        let repository: PodcastEpisodeRepositoryProtocol
        let streamer: StreamerInteractor.Environment
    }

    struct State: Equatable {
        var status: Status = .loading
        var podcast: Podcast
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
                    let emptyTimeField = StreamerUpdateViewModel.kEmptyTimeField
                    let artworkURL = container.episode.artworkURL ?? container.podcastArtworkURL
                    state.streamer = .init(
                        duration: emptyTimeField,
                        remaining: emptyTimeField,
                        artworkURL: artworkURL,
                        mediaURL: container.episode.mediaURL,
                        title: container.episode.title,
                        subtitle: container.episode.subtitle
                    )
                    state.container = container
                    return .none
                case .sheet:
                    state.container = nil
                    return .none
                case .appear:
                    switch state.status {
                    case .loading:
                        let podcastArtworkURL = state.podcast.artworkURL
                        return environment.repository
                            .fetchEpisodes(from: state.podcast.feedURL)
                            .map { results in
                                results
                                    .map { episode in
                                        let container = PodcastEpisodeContainer(
                                            podcastArtworkURL: podcastArtworkURL,
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
