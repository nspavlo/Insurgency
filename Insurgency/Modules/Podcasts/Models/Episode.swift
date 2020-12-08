//
//  Episode.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

typealias Episodes = [Episode]

// MARK: Initialization

struct Episode: Decodable {
    let url: URL
}
