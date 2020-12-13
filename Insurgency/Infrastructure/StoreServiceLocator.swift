//
//  StoreServiceLocator.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 11/12/2020.
//

import ComposableArchitecture

// MARK: Service Locator

enum StoreServiceLocator {
    static func podcasts() -> Store<PodcastListViewModel.State, PodcastListViewModel.Action> {
        PodcastListViewModel.store(
            with: PodcastListViewModel.Environment(
                repository: PodcastRepository(
                    session: .shared,
                    url: URLHost.production.url,
                    queue: .main
                ),
                queue: DispatchQueue.main.eraseToAnyScheduler()
            )
        )
    }

    static func podcastEpisodes(with podcast: Podcast) -> Store<PodcastEpisodeListViewModel.State, PodcastEpisodeListViewModel.Action> {
        PodcastEpisodeListViewModel.store(
            with: PodcastEpisodeListViewModel.Environment(
                repository: PodcastEpisodeRepository(
                    session: .shared,
                    url: URLHost.production.url,
                    queue: .main
                ),
                podcast: podcast,
                queue: DispatchQueue.main.eraseToAnyScheduler()
            )
        )
    }

    static func streamer(with episode: PodcastEpisode, podcastArtworkURL: URL) -> Store<StreamerViewModel.State, StreamerViewModel.Action> {
        StreamerViewModel.store(
            with: StreamerViewModel.Environment(
                episode: episode,
                podcastArtworkURL: podcastArtworkURL,
                streamer: AudioStreamer(url: episode.mediaURL)
            )
        )
    }
}
