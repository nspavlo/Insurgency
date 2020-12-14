//
//  PodcastEpisodeRepository.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 11/12/2020.
//

import Combine
import FeedKit
import Foundation

// MARK: Protocol

protocol PodcastEpisodeRepositoryProtocol {
    func fetchEpisodes(from url: URL) -> AnyPublisher<PodcastEpisodes, Failure>
}

// MARK: Initialization

struct PodcastEpisodeRepository: URLRepositoryProtocol {
    let session: URLSession
    let url: URL
    let queue: DispatchQueue
}

// MARK: Public Methods

extension PodcastEpisodeRepository: PodcastEpisodeRepositoryProtocol {
    func fetchEpisodes(from url: URL) -> AnyPublisher<PodcastEpisodes, Failure> {
        execute(URLRequest(url: url))
            .receive(on: DispatchQueue.global(qos: .default))
            .tryMap { result in try parseEpisodes(from: result.value) }
            .mapError { Failure(underlyingError: $0) }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}

// MARK: Private Methods

private extension PodcastEpisodeRepository {
    func parseEpisodes(from data: Data) throws -> PodcastEpisodes {
        let result = try FeedParser(data: data).parse().get()
        let items = result.rssFeed?.items ?? []
        return items.compactMap { PodcastEpisode($0) }
    }
}
