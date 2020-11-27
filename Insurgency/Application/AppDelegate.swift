//
//  AppDelegate.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import UIKit

// MARK: Initialization

@main
class AppDelegate: NSObject {}

// MARK: UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let multiplexer = AuthenticatorDelegateMultiplexer(delegates: [
            AuthenticatorPresenter(),
            FirebaseAnalyticsAuthenticatorTracker()
        ])

        let authenticator = Authenticator()
        authenticator.delegate = multiplexer

        let credentials = Credentials(username: "root", password: "password")
        authenticator.login(with: credentials)

        return true
    }
}
