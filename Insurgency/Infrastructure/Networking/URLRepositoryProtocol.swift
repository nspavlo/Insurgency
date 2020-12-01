//
//  URLRepositoryProtocol.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation
import Combine

// MARK: Initialization

protocol URLRepositoryProtocol {
    var session: URLSession { get }
    var url: URL { get }
    var queue: DispatchQueue { get }
}

// MARK: Default implementation

internal extension URLRepositoryProtocol {
    func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<URLRepositoryResponse<T>, Error> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { result -> URLRepositoryResponse<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return URLRepositoryResponse(value: value, response: result.response)
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }

    func execute<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, Error> {
        execute(request, decoder)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
