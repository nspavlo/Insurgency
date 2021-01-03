//
//  PodcastEpisodeListItemViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import Foundation

typealias PodcastEpisodeListItemViewModels = [PodcastEpisodeListItemViewModel]

// MARK: Initialization

struct PodcastEpisodeListItemViewModel: Hashable {
    var episode: PodcastEpisode {
        container.episode
    }

    var podcastArtworkURL: URL {
        container.podcastArtworkURL
    }

    let container: PodcastEpisodeContainer
}

// MARK: Adapter

extension PodcastEpisodeListItemViewModel: Identifiable {
    var id: URL {
        episode.mediaURL
    }

    var image: URL {
        episode.artworkURL ?? podcastArtworkURL
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
