//
//  TabBarView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct TabBarView: View {
    let store: Store<AppInteractor.State, AppInteractor.Action>
}

// MARK: View Construction

extension TabBarView {
    var body: some View {
        WithViewStore(store.stateless) { store in
            ZStack(alignment: .bottom) {
                TabView {
                    podcastsList()
                }
            }
        }
    }

    @ViewBuilder
    private func podcastsList() -> some View {
        PodcastListView(
            store: store.scope(
                state: { $0.podcasts },
                action: AppInteractor.Action.podcasts
            )
        )
        .tabItem {
            createItem(
                with: .search,
                title: Locale.searchItemName
            )
        }
    }

    @ViewBuilder
    private func createItem(with symbol: Symbol, title: String) -> some View {
        Group {
            Image(symbol: symbol)
            Text(title)
        }
    }
}

// MARK: Locale

private typealias Locale = String

private extension Locale {
    static let searchItemName = "Search"
}
