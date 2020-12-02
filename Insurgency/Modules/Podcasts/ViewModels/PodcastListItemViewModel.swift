//
//  PodcastListItemViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

// MARK: Initialization

struct PodcastListItemViewModel {
    private let podcast: Podcast

    init(podcast: Podcast) {
        self.podcast = podcast
    }
}

// MARK: Adapter

extension PodcastListItemViewModel: Identifiable {
    var id: Int { podcast.trackID }
    var imageName: String { "magnifyingglass" }
    var title: String { podcast.trackName }
}
