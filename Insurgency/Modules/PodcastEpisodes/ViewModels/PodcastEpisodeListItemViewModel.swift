//
//  PodcastEpisodeListItemViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import Foundation

typealias PodcastEpisodeListItemViewModels = [PodcastEpisodeListItemViewModel]

// MARK: Initialization

struct PodcastEpisodeListItemViewModel: Equatable {
    private let episode: PodcastEpisode

    init(episode: PodcastEpisode) {
        self.episode = episode
    }
}

// MARK: Adapter

extension PodcastEpisodeListItemViewModel: Identifiable {
    var id: URL {
        episode.stream
    }

    var image: URL {
        episode.image
    }

    var title: String {
        episode.title
    }

    var subtitle: String {
        episode.subtitle
    }

    var date: String {
        DateFormatter.mediumFormatDateFormatter
            .string(from: episode.date)
            .uppercased()
    }
}
