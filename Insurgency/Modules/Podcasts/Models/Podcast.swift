//
//  Podcast.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

// MARK: Initialization

struct Podcast: Decodable {
    let artistName: String
    let feedUrl: URL?
}

// MARK: Network Container

extension Podcast {
    struct NetworkResponse: Decodable {
        var results: [Podcast]
    }
}
