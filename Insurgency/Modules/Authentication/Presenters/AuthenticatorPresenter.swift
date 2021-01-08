//
//  AuthenticatorPresenter.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation
import OSLog

// MARK: Initialization

final class AuthenticatorPresenter {
    let logger = Logger(category: "AuthenticatorPresenter")
    let emoji = "📺"
}

// MARK: AuthenticatorDelegate

extension AuthenticatorPresenter: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        logger.info("[\(self.emoji)] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        logger.error("[\(self.emoji)] authenticator: \(authenticator), didEncounterError: \(error)")
    }
}
