//
//  Authenticator.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Delegate

protocol AuthenticatorDelegate: AnyObject {
    func authenticatorDidAuthenticate(_ authenticator: Authenticator)
    func authenticator(_ authenticator: Authenticator, didEncounter error: AuthenticatorError)
}

// MARK: Error

enum AuthenticatorError: Error {
    case unknown
}

// MARK: CustomStringConvertible

extension AuthenticatorError: CustomStringConvertible {
    var description: String {
        switch self {
        case .unknown:
            return "AuthenticatorError.unknown"
        }
    }
}

// MARK: Initialization

// swiftlint:disable weak_delegate

final class Authenticator {
    var delegate: AuthenticatorDelegate?
}

// MARK: Public Methods

extension Authenticator {
    func login(with _: Credentials) {
        delegate?.authenticatorDidAuthenticate(self)
        delegate?.authenticator(self, didEncounter: .unknown)
    }
}

// MARK: CustomStringConvertible

extension Authenticator: CustomStringConvertible {
    var description: String {
        "Authenticator(\(delegate.debugDescription))"
    }
}
