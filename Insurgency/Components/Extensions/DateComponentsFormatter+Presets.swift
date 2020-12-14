//
//  DateComponentsFormatter+Presets.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import Foundation

// MARK: Presets

extension DateComponentsFormatter {
    static let durationDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }()
}
