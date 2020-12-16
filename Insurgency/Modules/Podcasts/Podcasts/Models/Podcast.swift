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
    let id: Int
    let name: String
    let feedURL: URL
    let artworkURL: URL
}

// MARK: Decodable

extension Podcast: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case feedURL = "feedUrl"
        case artworkURL = "artworkUrl600"
    }
}

// MARK: Network Container

extension Podcast {
    struct NetworkResponse: Decodable {
        @LossyArray
        var results: Podcasts
    }
}
