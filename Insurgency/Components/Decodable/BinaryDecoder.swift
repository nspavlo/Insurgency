//
//  BinaryDecoder.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 04/01/2021.
//

import Foundation

// MARK: Initialization

struct BinaryDecoder: DecodableDecoder {
    func decode<T>(_: T.Type, from data: Data) throws -> T where T: Decodable {
        guard let data = data as? T else {
            preconditionFailure("Binary data decoder can only process binary data")
        }

        return data
    }
}
