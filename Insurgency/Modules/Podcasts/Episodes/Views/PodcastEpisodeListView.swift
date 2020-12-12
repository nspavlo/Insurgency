//
//  PodcastEpisodeListView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import Combine
import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct PodcastEpisodeListView: View {
    let store: Store<PodcastEpisodeListViewModel.State, PodcastEpisodeListViewModel.Action>
}

// MARK: View Construction

extension PodcastEpisodeListView {
    var body: some View {
        WithViewStore(store) { store in
            List {
                content(for: store.state)
            }
            .environment(\.defaultMinListRowHeight, 48)
            .navigationTitle(Locale.navigationBarTitle)
            .onAppear { store.send(.appear) }
        }
    }

    @ViewBuilder
    private func content(for state: PodcastEpisodeListViewModel.State) -> some View {
        switch state {
        case .loading:
            ListLoaderView(text: Locale.loading)
        case .result(.success(let viewModels)):
            ForEach(viewModels) { viewModel in
                let destination = StreamerView(viewModel: StreamerViewModel(episode: viewModel.episode))
                NavigationLink(destination: destination) {
                    PodcastEpisodeListItemView(viewModel: viewModel)
                }
            }
        case .result(.failure(let error)):
            Text(error.localizedDescription)
        }
    }
}

// MARK: Locale

private typealias Locale = String

private extension Locale {
    static let navigationBarTitle = "Episodes"
    static let loading = "Loading..."
}
