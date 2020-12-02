//
//  PodcastRowViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

// MARK: Initialization

struct PodcastRowViewModel {
    private let podcast: Podcast

    init(podcast: Podcast) {
        self.podcast = podcast
    }
}

// MARK: Adapter

extension PodcastRowViewModel: Identifiable {
    var id: Int {
        podcast.trackId
    }

    var title: String {
        podcast.artistName
    }
}
