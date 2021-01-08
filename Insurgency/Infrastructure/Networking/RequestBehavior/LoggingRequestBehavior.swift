//
//  LoggingRequestBehavior.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/01/2021.
//

import Foundation
import OSLog

// MARK: Initialization

final class LoggingRequestBehavior {
    let logger = Logger(category: "Networking")
}

// MARK: RequestBehavior

extension LoggingRequestBehavior: RequestBehavior {
    var headers: [String: String] {
        return [:]
    }

    func prepare(description: String) {
        logger.info("[📤] REQ: \(description)")
    }

    func success(result: Any) {
        logger.info("[📥] RES: \(String(describing: result))")

    }

    func failure(error: Error) {
        logger.info("[🐞] RES: \(String(describing: error))")
    }
}
