//
//  PodcastEpisodeContainer.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 21/12/2020.
//

import Foundation

// MARK: Initialization

struct PodcastEpisodeContainer {
    let podcastArtworkURL: URL
    let episode: PodcastEpisode
}

// MARK: Hashable

extension PodcastEpisodeContainer: Hashable {}
