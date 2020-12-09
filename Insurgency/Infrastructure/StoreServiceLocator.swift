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
        PodcastListViewModel.store(with: PodcastListViewModel.Environment(
            repository: PodcastRepository(
                session: .shared,
                url: URLHost.production.url,
                queue: .main
            ),
            queue: DispatchQueue.main.eraseToAnyScheduler()
        ))
    }

    static func podcastEpisodes(with url: URL) -> Store<PodcastEpisodeListViewModel.State, PodcastEpisodeListViewModel.Action> {
        PodcastEpisodeListViewModel.store(with: PodcastEpisodeListViewModel.Environment(
            repository: PodcastEpisodeRepository(
                session: .shared,
                url: URLHost.production.url,
                queue: .main
            ),
            url: url,
            queue: DispatchQueue.main.eraseToAnyScheduler()
        ))
    }
}
