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
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let authenticator = AuthenticatorFactory().make()
        authenticator.login(with: Credentials(username: "root", password: "password"))

        return true
    }
}
