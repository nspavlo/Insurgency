//
//  URLRepositoryProtocol.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation
import Combine

// MARK: Failure

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

// MARK: Initialization

protocol URLRepositoryProtocol {
    var session: URLSession { get }
    var url: URL { get }
    var queue: DispatchQueue { get }
}

// MARK: Default Implementation

internal extension URLRepositoryProtocol {
    func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder
    ) -> AnyPublisher<URLRepositoryResponse<T>, Failure> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { result -> URLRepositoryResponse<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return URLRepositoryResponse(value: value, response: result.response)
            }
            .mapError { Failure(underlyingError: $0) }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }

    func execute(
        _ request: URLRequest
    ) -> AnyPublisher<URLRepositoryResponse<Data>, Failure> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { result -> URLRepositoryResponse<Data> in
                URLRepositoryResponse(value: result.data, response: result.response)
            }
            .mapError { Failure(underlyingError: $0) }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
