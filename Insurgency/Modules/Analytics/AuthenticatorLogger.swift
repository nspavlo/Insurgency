//
//  AuthenticatorLogger.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

final class AuthenticatorLogger {
    let emoji = "🔐"
}

// MARK: AuthenticatorDelegate

extension AuthenticatorLogger: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        print("**** [\(emoji)] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        print("**** [\(emoji)] authenticator: \(authenticator), didEncounterError: \(error)")
    }
}
