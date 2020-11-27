//
//  SceneDelegateSpec.swift
//  InsurgencyTests
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Quick
import Nimble
import SpecLeaks

@testable import Insurgency

class SceneDelegateSpec: QuickSpec {
    override func spec() {
        describe("SceneDelegate process") {
            describe("leaks") {
                describe("when initilized") {
                    let sut = LeakTest { SceneDelegate() }

                    it("must not leak") {
                        expect(sut).toNot(leak())
                    }
                }
            }
        }
    }
}
