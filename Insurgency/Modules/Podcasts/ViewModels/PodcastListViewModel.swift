//
//  PodcastListViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import Foundation
import Combine

// MARK: Initialization

final class PodcastListViewModel: ObservableObject {
    @Published private(set) var title = "Search"
    @Published private(set) var rows = [PodcastListItemViewModel]()

    @Published var placeholder = "All Podcasts"
    @Published var term = ""

    private let repository: PodcastRepositoryProtocol
    private let scheduler: DispatchQueue
    private var disposables = Set<AnyCancellable>()

    init(repository: PodcastRepositoryProtocol, scheduler: DispatchQueue) {
        self.repository = repository
        self.scheduler = scheduler
        self.setup()
    }
}

// MARK: Private Methods

private extension PodcastListViewModel {
    func setup() {
        $term
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchPodcasts(with:))
            .store(in: &disposables)
    }

    func fetchPodcasts(with term: String) {
        repository.fetchPodcasts(with: term)
            .map { response in
                response.results.map(PodcastListItemViewModel.init)
            }
            .sink(
                receiveCompletion: { [weak self] value in
                    switch value {
                    case .failure:
                        self?.rows = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] rows in
                    self?.rows = rows
                })
            .store(in: &disposables)
    }
}
