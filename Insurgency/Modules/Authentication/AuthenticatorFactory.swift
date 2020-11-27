//
//  AuthenticatorFactory.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

struct AuthenticatorFactory {
    func make() -> Authenticator {
        let delegate = AuthenticatorDelegateMultiplexer(delegates: [
            AuthenticatorPresenter(),
            AuthenticatorLogger(),
            FirebaseAnalyticsAuthenticatorTracker()
        ])

        let authenticator = Authenticator()
        authenticator.delegate = delegate

        return authenticator
    }
}
