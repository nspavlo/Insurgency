//
//  URLHost.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

// MARK: Initialization

enum URLHost: String {
    case production = "https://itunes.apple.com/"
}

// MARK: Convenience

extension URLHost {
    var url: URL {
        guard let url = URL(string: rawValue) else {
            preconditionFailure("Unable to create url with rawValue: \(rawValue)")
        }

        return url
    }
}
