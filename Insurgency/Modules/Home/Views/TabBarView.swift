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
        TabView {
            podcastList()
                .tabItem {
                    Image(symbol: .search)
                    Text(Locale.searchItemName)
                }
        }
    }

    private func podcastList() -> some View {
        PodcastListView(
            store: store.scope(
                state: { $0.podcasts },
                action: AppInteractor.Action.podcasts
            )
        )
    }
}

// MARK: Locale

private typealias Locale = String

private extension Locale {
    static let searchItemName = "Search"
}
