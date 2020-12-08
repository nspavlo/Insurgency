//
//  URLRepositoryProtocol.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation
import Combine

// MARK: Failure

struct Failure: Error, Equatable {}

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
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<URLRepositoryResponse<T>, Failure> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { result -> URLRepositoryResponse<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return URLRepositoryResponse(value: value, response: result.response)
            }
            .mapError { _ in Failure() }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }

    func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, Failure> {
        execute(request, decoder)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
