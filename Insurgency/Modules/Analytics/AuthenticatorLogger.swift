//
//  AuthenticatorLogger.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

final class AuthenticatorLogger {
    let id = "🔐"
}

// MARK: AuthenticatorDelegate

extension AuthenticatorLogger: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        print("**** [\(id)] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        print("**** [\(id)] authenticator: \(authenticator), didEncounterError: \(error)")
    }
}
