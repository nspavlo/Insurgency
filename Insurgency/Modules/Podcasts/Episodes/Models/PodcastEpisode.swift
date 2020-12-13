//
//  PodcastEpisode.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

typealias PodcastEpisodes = [PodcastEpisode]

// MARK: Initialization

struct PodcastEpisode: Equatable {
    let title: String
    let subtitle: String
    let date: Date
    let artworkURL: URL?
    let mediaURL: URL
}
