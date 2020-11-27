//
//  AuthenticatorFactorySpec.swift
//  InsurgencyTests
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Quick
import Nimble

@testable import Insurgency

class AuthenticatorFactorySpec: QuickSpec {
    override func spec() {
        describe("Authenticator factory process") {
            context("when make method is executed") {
                let sut = AuthenticatorFactory()
                let result = sut.make()

                it("makes authenticator") {
                    expect(result).to(beAKindOf(Authenticator.self))
                }

                it("delegates to 'AuthenticatorDelegate' multiplexer") {
                    expect(result.delegate).to(beAKindOf(AuthenticatorDelegateMultiplexer.self))
                }

                describe("multiplexer") {
                    let multiplexer = result.delegate as? AuthenticatorDelegateMultiplexer

                    it("delegates to 'FirebaseAnalyticsAuthenticatorTracker'") {
                        expect(multiplexer?.delegates).to(containElementSatisfying { delegate in
                            delegate is FirebaseAnalyticsAuthenticatorTracker
                        })
                    }

                    it("delegates to 'AuthenticatorPresenter'") {
                        expect(multiplexer?.delegates).to(containElementSatisfying { delegate in
                            delegate is AuthenticatorPresenter
                        })
                    }
                }
            }
        }
    }
}
