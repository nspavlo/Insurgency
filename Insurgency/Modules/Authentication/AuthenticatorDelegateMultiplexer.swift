//
//  AuthenticatorDelegateMultiplexer.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

final class AuthenticatorDelegateMultiplexer {
    private var delegates: [AuthenticatorDelegate] = []

    init(delegates: [AuthenticatorDelegate]) {
        self.delegates = delegates
    }
}

// MARK: AuthenticatorDelegate

extension AuthenticatorDelegateMultiplexer: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        delegates.forEach { $0.authenticatorDidAuthenticate(authenticator) }
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        delegates.forEach { $0.authenticator(authenticator, didEncounter: error) }
    }
}
