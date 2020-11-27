//
//  RegisterUserDefaultsCommand.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import Foundation

// MARK: Initialization

struct RegisterUserDefaultsCommand {
    let defaults: UserDefaults
}

// MARK: Command

extension RegisterUserDefaultsCommand: Command {
    func execute() {
        defaults.register(defaults: [:])
    }
}
