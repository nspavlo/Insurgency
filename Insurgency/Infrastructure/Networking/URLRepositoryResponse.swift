//
//  URLRepositoryResponse.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation

// MARK: Initialization

struct URLRepositoryResponse<T> {
    let value: T
    let response: URLResponse
}
