//
//  MediaNameView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct MediaNameView: View {
    let store: Store<StreamerViewModel.State, StreamerViewModel.Action>
}

// MARK: View Construction

extension MediaNameView {
    var body: some View {
        WithViewStore(store) { store in
            VStack(alignment: .leading, spacing: 0) {
                Text(store.state.title)
                    .foregroundColor(.primary)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .frame(alignment: .leading)

                Text(store.state.subtitle)
                    .foregroundColor(.secondary)
                    .font(.title3)
                    .fontWeight(.none)
                    .lineLimit(1)
                    .frame(alignment: .leading)
            }
        }
    }
}
