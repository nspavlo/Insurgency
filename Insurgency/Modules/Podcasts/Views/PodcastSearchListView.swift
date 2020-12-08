//
//  PodcastSearchListView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import Combine
import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct PodcastSearchListView: View {
    let store: Store<PodcastSearchViewModel.State, PodcastSearchViewModel.Action>
}

// MARK: View Construction

extension PodcastSearchListView {
    var body: some View {
        WithViewStore(store) { store in
            NavigationView {
                List {
                    content(for: store.state)
                }
                .navigationBarTitle(Locale.navigationBarTitle)
                .navigationBarSearch(
                    text: store.binding(
                        get: { state in state.term },
                        send: PodcastSearchViewModel.Action.search
                    ),
                    placeholder: Locale.searchFieldPlaceholder
                )
                .environment(\.defaultMinListRowHeight, 48)
            }
        }
    }

    @ViewBuilder
    private func content(for state: PodcastSearchViewModel.State) -> some View {
        switch state {
        case .initial,
             .search:
            EmptyView()
        case .loading:
            PodcastListLoaderView(text: Locale.loading)
        case .result(.success(let viewModels)):
            ForEach(viewModels) { viewModel in
                NavigationLink(destination: EmptyView()) {
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
