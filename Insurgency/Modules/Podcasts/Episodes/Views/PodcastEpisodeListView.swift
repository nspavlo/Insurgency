//
//  PodcastEpisodeListView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct PodcastEpisodeListView: View {
    let store: Store<PodcastEpisodeListInteractor.State, PodcastEpisodeListInteractor.Action>
}

// MARK: View Construction

extension PodcastEpisodeListView {
    var body: some View {
        WithViewStore(store) { store in
            List {
                content(for: store)
            }
            .environment(\.defaultMinListRowHeight, 48)
            .navigationTitle(Locale.navigationBarTitle)
            .onAppear { store.send(.appear) }
            .sheet(
                isPresented: store.binding(
                    get: { $0.isSheetPresented },
                    send: PodcastEpisodeListInteractor.Action.sheet(isPresented:)
                ),
                content: {
                    IfLetStore(
                        self.store.scope(
                            state: { $0.streamer },
                            action: PodcastEpisodeListInteractor.Action.streamer
                        ),
                        then: StreamerView.init(store:)
                    )
                }
            )
        }
    }

    @ViewBuilder
    private func content(
        for store: ViewStore<PodcastEpisodeListInteractor.State, PodcastEpisodeListInteractor.Action>
    ) -> some View {
        switch store.status {
        case .loading:
            ListLoaderView(text: Locale.loading)
        case .result(.success(let viewModels)):
            ForEach(viewModels, id: \.self) { viewModel in
                Button(
                    action: {
                        store.send(.select(container: viewModel.container))
                    },
                    label: {
                        PodcastEpisodeListItemView(viewModel: viewModel)
                    }
                )
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
