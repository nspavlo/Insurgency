//
//  DecodableDecoder.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 04/01/2021.
//

import Foundation

// MARK: Protocol

protocol DecodableDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}
