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
                        get: { state in state.searchTerm },
                        send: PodcastSearchViewModel.Action.search
                    ),
                    placeholder: Locale.searchFieldPlaceholder
                )
                .environment(\.defaultMinListRowHeight, 48)
                .onAppear { store.send(.appear) }
            }
        }
    }

    private func content(for state: PodcastSearchViewModel.State) -> some View {
        switch state {
        case .initial,
             .search:
            return EmptyView()
                .eraseToAnyView()
        case .loading:
            return PodcastListLoaderView(text: Locale.loading)
                .eraseToAnyView()
        case .result(.success(let viewModels)):
            return ForEach(viewModels, content: PodcastListItemView.init(viewModel:))
                .eraseToAnyView()
        case .result(.failure(let error)):
            return Text(error.localizedDescription)
                .eraseToAnyView()
        }
    }
}

// MARK: Locale

typealias Locale = String

private extension Locale {
    static let navigationBarTitle = "Search"
    static let searchFieldPlaceholder = "Podcasts"
    static let loading = "Loading..."
}
