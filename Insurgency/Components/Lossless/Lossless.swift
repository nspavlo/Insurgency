//
//  Lossless.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 15/12/2020.
//

import Foundation

// MARK: Initialization

struct Lossless<T: Decodable> {
    let result: Result<T, Error>
}

// MARK: Decodable

extension Lossless: Decodable {
    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}
