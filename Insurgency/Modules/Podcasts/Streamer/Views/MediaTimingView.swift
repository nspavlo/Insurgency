//
//  MediaTimingView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct MediaTimingView: View {
    let store: Store<StreamerViewModel.State, StreamerViewModel.Action>
}

// MARK: View Construction

extension MediaTimingView {
    var body: some View {
        WithViewStore(store) { store in
            VStack {
                ProgressView(
                    value: CGFloat(store.state.progress),
                    trackColor: Color(UIColor.tertiaryLabel),
                    progressColor: .secondary,
                    height: 3)

                HStack {
                    Text(store.state.duration)
                        .modifier(MonospacedLabelModifier())

                    Spacer()

                    Text(store.state.remaining)
                        .modifier(MonospacedLabelModifier())
                }
            }
        }
    }
}
