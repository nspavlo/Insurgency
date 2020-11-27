//
//  AuthenticatorPresenter.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

final class AuthenticatorPresenter {}

// MARK: AuthenticatorDelegate

extension AuthenticatorPresenter: AuthenticatorDelegate {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator) {
        print("**** [📺] authenticatorDidAuthenticate: \(authenticator)")
    }

    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError) {
        print("**** [📺] authenticator: \(authenticator), didEncounterError: \(error)")
    }
}