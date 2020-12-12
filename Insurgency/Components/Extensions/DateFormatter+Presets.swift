//
//  DateFormatter+Presets.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 11/12/2020.
//

import Foundation

// MARK: DateFormatter

extension DateFormatter {
    static let mediumFormatDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
        return formatter
    }()
}

// MARK: DateComponentsFormatter

extension DateComponentsFormatter {
    static let durationDateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }()
}
