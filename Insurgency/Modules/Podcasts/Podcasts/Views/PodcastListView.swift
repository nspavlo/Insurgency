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
                    content(for: store)
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
    private func content(
        for store: ViewStore<PodcastListInteractor.State, PodcastListInteractor.Action>
    ) -> some View {
        switch store.status {
        case .initial:
            EmptyView()
        case .search:
            ListLoaderView(text: Locale.loading)
        case .result(.success(let viewModels)):
            ForEach(viewModels, id: \.self) { viewModel in
                NavigationLink(
                    destination: IfLetStore(
                        self.store.scope(
                            state: { $0.selection?.value },
                            action: PodcastListInteractor.Action.episode
                        ),
                        then: PodcastEpisodeListView.init(store:)
                    ),
                    tag: viewModel.id,
                    selection: store.binding(
                        get: { $0.selection?.id },
                        send: PodcastListInteractor.Action.navigation(selection:)
                    )
                ) {
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
