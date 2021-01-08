//
//  RequestBehavior.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/01/2021.
//

import Foundation

// MARK: Initialization

protocol RequestBehavior {
    var headers: [String: String] { get }

    func prepare(description: String)
    func success(result: Any)
    func failure(error: Error)
}

// MARK: Default Implementation

extension RequestBehavior {
    var headers: [String: String] {
        [:]
    }

    func prepare(description _: String) {}
    func success(result _: Any) {}
    func failure(error _: Error) {}
}
