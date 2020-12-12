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
    let url: URL?
}

// MARK: Decodable

extension Podcast: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case url = "feedUrl"
    }
}

// MARK: Network Container

extension Podcast {
    struct NetworkResponse: Decodable {
        var results: Podcasts
    }
}
