//
//  AppDelegate.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import UIKit

// MARK: Initialization

@main
class AppDelegate: NSObject {
    private func execute(with options: [UIApplication.LaunchOptionsKey: Any]?) {
        AppDelegateCommandBuilder()
            .setupLaunchingOptions(options)
            .make()
            .execute()
    }
}

// MARK: UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        execute(with: options)
        return true
    }
}
