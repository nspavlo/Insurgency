//
//  FirebaseAnalyticsAuthenticatorTracker.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

final class FirebaseAnalyticsAuthenticatorTracker {}

// MARK: AuthenticatorDelegate

extension FirebaseAnalyticsAuthenticatorTracker: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        print("**** [Firebase] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        print("**** [Firebase] authenticatorDidAuthenticate: \(authenticator), didEncounter: \(error)")
    }
}
