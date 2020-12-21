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
    let store: Store<StreamerInteractor.State, StreamerInteractor.Action>
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

// MARK: ViewModifiers

private struct MonospacedLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(UIColor.tertiaryLabel))
            .font(Font.system(.caption, design: .monospaced).weight(.bold))
    }
}
