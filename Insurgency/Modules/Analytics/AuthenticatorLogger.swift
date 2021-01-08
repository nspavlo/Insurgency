//
//  AuthenticatorLogger.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation
import OSLog

// MARK: Initialization

final class AuthenticatorLogger {
    let logger = Logger(category: "Authentication")
    let emoji = "🔐"
}

// MARK: AuthenticatorDelegate

extension AuthenticatorLogger: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        logger.info("[\(self.emoji)] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        logger.error("[\(self.emoji)] authenticator: \(authenticator), didEncounterError: \(error)")
    }
}
