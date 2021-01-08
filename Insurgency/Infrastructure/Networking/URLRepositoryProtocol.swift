//
//  URLRepositoryProtocol.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Combine
import Foundation

// MARK: Initialization

protocol URLRepositoryProtocol {
    var session: URLSession { get }
    var url: URL { get }
    var queue: DispatchQueue { get }
    var behavior: RequestBehavior { get }
}

// MARK: Default Implementation

internal extension URLRepositoryProtocol {
    func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: DecodableDecoder
    ) -> AnyPublisher<URLRepositoryResponse<T>, Failure> {
        behavior.prepare(description: request.description)

        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> URLRepositoryResponse<T> in
                behavior.success(result: result)
                let value = try decoder.decode(T.self, from: result.data)
                return URLRepositoryResponse(value: value, response: result.response)
            }
            .mapError { error in
                behavior.failure(error: error)
                return Failure(underlyingError: error)
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
