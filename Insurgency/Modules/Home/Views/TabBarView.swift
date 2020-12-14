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
                    PodcastListView(
                        store: self.store.scope(
                            state: { $0.podcasts },
                            action: AppInteractor.Action.podcasts
                        )
                    )
                    .tabItem {
                        Image(symbol: .search)
                        Text(Locale.searchItemName)
                    }
                }
            }
            .onAppear { store.send(.appear) }
        }
    }
}

// MARK: Locale

private typealias Locale = String

private extension Locale {
    static let searchItemName = "Search"
}
