//
//  PodcastRepository.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Combine
import Foundation

// MARK: Protocol

protocol PodcastRepositoryProtocol {
    func fetchPodcasts(with term: String) -> AnyPublisher<Podcast.NetworkResponse, Failure>
}

// MARK: Initialization

struct PodcastRepository: URLRepositoryProtocol {
    let session: URLSession
    let url: URL
    let queue: DispatchQueue
}

// MARK: Public Methods

extension PodcastRepository: PodcastRepositoryProtocol {
    func fetchPodcasts(with term: String) -> AnyPublisher<Podcast.NetworkResponse, Failure> {
        // TODO:
        // Filter out podcasts w/o `url`
        // Make `url` mandatory
        execute(URLRequest(url: createPodcastEndpoint(with: term)), JSONDecoder())
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

// MARK: Private Methods

private extension PodcastRepository {
    func createPodcastEndpoint(with term: String) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "media", value: "podcast")
        ]
        return components.url!
    }
}
