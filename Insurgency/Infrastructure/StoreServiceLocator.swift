//
//  StoreServiceLocator.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 11/12/2020.
//

import ComposableArchitecture

// MARK: Service Locator

// TODO:
// Remove / Inject using scope

enum StoreServiceLocator {
    static func podcastEpisodes(
        with podcast: Podcast
    ) -> Store<PodcastEpisodeListInteractor.State, PodcastEpisodeListInteractor.Action> {
        PodcastEpisodeListInteractor.store(
            with: PodcastEpisodeListInteractor.Environment(
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
}
