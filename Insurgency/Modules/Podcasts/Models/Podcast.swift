//
//  Podcast.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

typealias Podcasts = [Podcast]

// MARK: Initialization

struct Podcast: Equatable {
    let trackID: Int
    let trackName: String
    let feedURL: URL?
}

// MARK: Decodable

extension Podcast: Decodable {
    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case trackName
        case feedURL = "feedUrl"
    }
}

// MARK: Network Container

extension Podcast {
    struct NetworkResponse: Decodable {
        var results: Podcasts
    }
}
