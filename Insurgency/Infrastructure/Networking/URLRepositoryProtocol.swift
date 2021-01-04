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
}

// MARK: Default Implementation

internal extension URLRepositoryProtocol {
    func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: DecodableDecoder
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
}
