//
//  LosslessArray.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 15/12/2020.
//

import Foundation

// MARK: Initialization

@propertyWrapper
struct LosslessArray<T: Decodable> {
    var wrappedValue: [T]

    init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: Decodable

extension LosslessArray: Decodable {
    private struct AnyDecodable: Decodable {}

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var wrappers: [Lossless<T>] = []

        while !container.isAtEnd {
            do {
                let wrapper = try container.decode(Lossless<T>.self)
                wrappers.append(wrapper)
            } catch {
                _ = try? container.decode(AnyDecodable.self)
            }
        }

        wrappedValue = wrappers.compactMap { try? $0.result.get() }
    }
}
