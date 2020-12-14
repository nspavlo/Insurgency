//
//  DateFormatter+Presets.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 11/12/2020.
//

import Foundation

// MARK: Presets

extension DateFormatter {
    static let mediumFormatDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
        return formatter
    }()
}
