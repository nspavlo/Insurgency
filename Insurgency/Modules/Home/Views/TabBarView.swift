//
//  TabBarView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import SwiftUI

// MARK: Initialization

struct TabBarView: View {}

// MARK: View Construction

extension TabBarView {
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                PodcastListView(store: StoreServiceLocator.podcasts())
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text(Locale.searchItemName)
                    }
            }
        }
    }
}

// MARK: Locale

private typealias Locale = String

private extension Locale {
    static let searchItemName = "Search"
}
