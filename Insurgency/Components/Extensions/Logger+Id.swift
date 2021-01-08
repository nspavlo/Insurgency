//
//  Logger+Id.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/01/2021.
//

import OSLog

extension Logger {
    init(_ bundle: Bundle = .main, category: String? = nil) {
        self.init(
            subsystem: bundle.bundleIdentifier ?? "default",
            category: category ?? "default"
        )
    }
}
