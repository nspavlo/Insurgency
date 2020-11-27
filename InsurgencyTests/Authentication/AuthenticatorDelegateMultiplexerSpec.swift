//
//  AuthenticatorDelegateMultiplexerSpec.swift
//  InsurgencyTests
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Quick
import Nimble

@testable import Insurgency

class AuthenticatorDelegateMultiplexerSpec: QuickSpec {
    override func spec() {
        describe("AuthenticatorDelegate multiplexer process") {
            context("given empty array of delegates") {
                context("when didAuthenticate method is executed") {
                    let sut = AuthenticatorDelegateMultiplexer(delegates: [])
                    sut.authenticatorDidAuthenticate(Authenticator())

                    it("does not crash") {}
                }

                context("when didEncounterError is executed") {
                    let sut = AuthenticatorDelegateMultiplexer(delegates: [])
                    sut.authenticator(Authenticator(), didEncounter: .unknown)

                    it("does not crash") {}
                }
            }

            context("given one delegate") {
                context("when didAuthenticate method is executed") {
                    let spy = AuthenticatorDelegateSpy()
                    let sut = AuthenticatorDelegateMultiplexer(delegates: [spy])
                    sut.authenticatorDidAuthenticate(Authenticator())

                    it("delegates didAuthenticate message") {
                        expect(spy.didAuthenticateCount).to(equal(1))
                    }

                    it("doesn't delegate didEncounterError message") {
                        expect(spy.didEncounterErrorCount).to(equal(0))
                    }
                }

                context("when didEncounterError is executed") {
                    let spy = AuthenticatorDelegateSpy()
                    let sut = AuthenticatorDelegateMultiplexer(delegates: [spy])
                    sut.authenticator(Authenticator(), didEncounter: .unknown)

                    it("delegates didEncounterError message") {
                        expect(spy.didEncounterErrorCount).to(equal(1))
                    }

                    it("doesn't delegate didAuthenticate message") {
                        expect(spy.didAuthenticateCount).to(equal(0))
                    }
                }
            }

            context("given miltiple delegates") {
                context("when didAuthenticate method is executed") {
                    let spies = [AuthenticatorDelegateSpy(), AuthenticatorDelegateSpy()]
                    let sut = AuthenticatorDelegateMultiplexer(delegates: spies)
                    sut.authenticatorDidAuthenticate(Authenticator())

                    it("delegates didAuthenticate message") {
                        expect(spies).notTo(containElementSatisfying({ $0.didAuthenticateCount == 0 }))
                    }

                    it("doesn't delegate didEncounterError message") {
                        expect(spies).notTo(containElementSatisfying({ $0.didEncounterErrorCount == 1 }))
                    }
                }

                context("when didEncounterError is executed") {
                    let spies = [AuthenticatorDelegateSpy(), AuthenticatorDelegateSpy()]
                    let sut = AuthenticatorDelegateMultiplexer(delegates: spies)
                    sut.authenticator(Authenticator(), didEncounter: .unknown)

                    it("delegates didEncounterError message") {
                        expect(spies).notTo(containElementSatisfying({ $0.didAuthenticateCount == 1 }))
                    }

                    it("doesn't delegate didAuthenticate message") {
                        expect(spies).notTo(containElementSatisfying({ $0.didEncounterErrorCount == 0 }))
                    }
                }
            }
        }
    }
}

// MARK: -

// MARK: AuthenticatorDelegateSpy
// MARK: Initialization

final class AuthenticatorDelegateSpy {
    private(set) var didAuthenticateCount: Int = 0
    private(set) var didEncounterErrorCount: Int = 0
}

// MARK: AuthenticatorDelegate

extension AuthenticatorDelegateSpy: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        didAuthenticateCount += 1
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        didEncounterErrorCount += 1
    }
}
