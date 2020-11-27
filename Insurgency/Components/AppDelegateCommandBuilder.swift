//
//  AppDelegateCommandBuilder.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import UIKit

// MARK: Initialization

final class AppDelegateCommandBuilder {
    private var options: [UIApplication.LaunchOptionsKey: Any]?
}

// MARK: Public Methods

extension AppDelegateCommandBuilder {
    func setupLaunchingOptions(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> AppDelegateCommandBuilder {
        self.options = options
        return self
    }

    func make() -> [Command] {
        [
            RegisterUserDefaultsCommand(defaults: .standard)
        ]
    }
}

// MARK: Convenience

extension Array where Element == Command {
    func execute() {
        forEach { $0.execute() }
    }
}
