//
//  PodcastListView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct PodcastListView: View {
    let store: Store<PodcastListInteractor.State, PodcastListInteractor.Action>
}

// MARK: View Construction

extension PodcastListView {
    var body: some View {
        NavigationView {
            WithViewStore(store) { store in
                List {
                    content(for: store.state.status)
                }
                .environment(\.defaultMinListRowHeight, 48)
                .navigationBarTitle(Locale.navigationBarTitle)
                .navigationBarSearch(
                    text: store.binding(
                        get: { state in state.term },
                        send: PodcastListInteractor.Action.search
                    ),
                    placeholder: Locale.searchFieldPlaceholder
                )
            }
        }
    }

    @ViewBuilder
    private func content(for state: PodcastListInteractor.Status) -> some View {
        switch state {
        case .initial:
            EmptyView()
        case .search:
            ListLoaderView(text: Locale.loading)
        case .result(.success(let viewModels)):
            ForEach(viewModels) { viewModel in
                let store = StoreServiceLocator.podcastEpisodes(with: viewModel.podcast)
                NavigationLink(destination: PodcastEpisodeListView(store: store)) {
                    PodcastListItemView(viewModel: viewModel)
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
    static let navigationBarTitle = "Search"
    static let searchFieldPlaceholder = "Podcasts"
    static let loading = "Loading..."
}
