//
//  FirebaseAnalyticsAuthenticatorTracker.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation
import OSLog

// MARK: Initialization

final class FirebaseAnalyticsAuthenticatorTracker {
    let logger = Logger(category: "Firebase")
    let emoji = "🔥"
}

// MARK: AuthenticatorDelegate

extension FirebaseAnalyticsAuthenticatorTracker: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        logger.info("[\(self.emoji)] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        logger.error("[\(self.emoji)] authenticator: \(authenticator), didEncounterError: \(error)")
    }
}
