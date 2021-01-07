//
//  LossyArraySpec.swift
//  InsurgencyTests
//
//  Created by Jans Pavlovs on 07/01/2021.
//

import Quick
import Nimble
import Foundation

@testable import Insurgency

class LossyArraySpec: QuickSpec {
    override func spec() {
        describe("Lossy decoding process") {
            context("given array with valid and invalid elements") {
                let string = #"{ "values": ["a", null, "c", "d"] }"#
                let data = string.data(using: .utf8)!

                let sut = try! JSONDecoder().decode(Fixture.self, from: data)

                it("ignores invalid elements") {
                    expect(sut.values).to(equal(["a", "c", "d"]))
                }
            }
        }
    }
}

// MARK: -

struct Fixture: Decodable {
    @LossyArray
    var values: [String]
}
