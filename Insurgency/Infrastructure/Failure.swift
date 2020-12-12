//
//  Failure.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 13/12/2020.
//

import Foundation

// MARK: Initialization

struct Failure: Error {
    let underlyingError: Error

    var localizedDescription: String {
        underlyingError.localizedDescription
    }
}

// MARK: Equatable

extension Failure: Equatable {
    static func == (lhs: Failure, rhs: Failure) -> Bool {
        (lhs.underlyingError as NSError) == (rhs.underlyingError as NSError)
    }
}
