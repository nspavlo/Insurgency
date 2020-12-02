//
//  PodcastListView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import SwiftUI
import Combine

// MARK: Initialization

struct PodcastListView: View {
    @ObservedObject var viewModel: PodcastListViewModel
}

// MARK: View Construction

extension PodcastListView {
    var body: some View {
        NavigationView {
            List {
                if !viewModel.rows.isEmpty {
                    Section {
                        ForEach(viewModel.rows, content: PodcastListItemView.init(viewModel:))
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 48)
            .navigationBarTitle(viewModel.title)
            .overlay(NavigationSearch(text: $viewModel.term, placeholder: $viewModel.placeholder).frame(width: 0, height: 0))
        }
    }
}

// MARK: Preview

struct PodcastView_Previews: PreviewProvider {
    struct PreviewPodcastRepository: PodcastRepositoryProtocol {
        func fetchEpisode(with url: URL) -> AnyPublisher<URL, Error> {
            Result<URL, Error>.Publisher(URL(string: "")!)
                .eraseToAnyPublisher()
        }

        func fetchPodcastFeed(with url: URL) -> AnyPublisher<[Episode], Error> {
            Result<[Episode], Error>.Publisher([])
                .eraseToAnyPublisher()
        }

        func fetchPodcasts(with term: String) -> AnyPublisher<Podcast.NetworkResponse, Error> {
            Result<Podcast.NetworkResponse, Error>.Publisher(Podcast.NetworkResponse(results: []))
                .eraseToAnyPublisher()
        }
    }

    static var previews: some View {
        let viewModel = PodcastListViewModel(
            repository: PreviewPodcastRepository(),
            scheduler: .main
        )
        return PodcastListView(viewModel: viewModel)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
