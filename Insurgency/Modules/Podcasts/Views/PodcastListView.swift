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

    init(viewModel: PodcastListViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: View Construction

extension PodcastListView {
    var body: some View {
        NavigationView {
            List {
                TextField("All Podcasts", text: $viewModel.term)
                    .modifier(TextFieldClearButton(text: $viewModel.term))
                    .padding(8)
                    .foregroundColor(Color(UIColor.label))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)

                if !viewModel.rows.isEmpty {
                    Section {
                        ForEach(viewModel.rows, content: PodcastRowView.init(viewModel:))
                    }
                }
            }
            .listStyle(DefaultListStyle())
            .environment(\.defaultMinListRowHeight, 48)
            .navigationBarTitle("Search")
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
            .previewDisplayName("Default preview")
    }
}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        HStack {
            content

            if !text.isEmpty {
                Button(
                    action: {
                        text = ""
                    },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}
