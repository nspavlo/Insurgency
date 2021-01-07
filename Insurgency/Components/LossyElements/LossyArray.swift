//
//  LossyArray.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 15/12/2020.
//

import Foundation

// MARK: Initialization

@propertyWrapper
struct LossyArray<T: Decodable> {
    var wrappedValue: [T]

    init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: Decodable

extension LossyArray: Decodable {
    private struct AnyDecodable: Decodable {}

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [T] = []

        while !container.isAtEnd {
            do {
                let wrapper = try container.decode(T.self)
                elements.append(wrapper)
            } catch {
                _ = try? container.decode(AnyDecodable.self)
            }
        }

        wrappedValue = elements
    }
}
