//
//  PodcastListItemViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

typealias PodcastListItemViewModels = [PodcastListItemViewModel]

// MARK: Initialization

struct PodcastListItemViewModel: Equatable {
    let podcast: Podcast

    init(podcast: Podcast) {
        self.podcast = podcast
    }
}

// MARK: Identifiable

extension PodcastListItemViewModel: Identifiable {
    var id: Int { podcast.id }
}

// MARK: Adapter

extension PodcastListItemViewModel {
    var title: String { podcast.name }
    var systemImageNamed: String { "magnifyingglass" }
}
