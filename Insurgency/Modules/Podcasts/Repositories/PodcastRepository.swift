//
//  PodcastRepository.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation
import Combine

// MARK: Protocol

protocol PodcastRepositoryProtocol {
    func fetchEpisode(with url: URL) -> AnyPublisher<URL, Failure>
    func fetchPodcastFeed(with url: URL) -> AnyPublisher<[Episode], Failure>
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
    func fetchEpisode(with url: URL) -> AnyPublisher<URL, Failure> {
        execute(URLRequest(url: url))
    }

    func fetchPodcastFeed(with url: URL) -> AnyPublisher<[Episode], Failure> {
        execute(URLRequest(url: url))
    }

    func fetchPodcasts(with term: String) -> AnyPublisher<Podcast.NetworkResponse, Failure> {
        execute(URLRequest(url: createPodcastEndpoint(with: term)))
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
