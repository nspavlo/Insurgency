//
//  MediaControlView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct MediaControlView: View {
    let store: Store<StreamerViewModel.State, StreamerViewModel.Action>
}

// MARK: View Construction

extension MediaControlView {
    var body: some View {
        WithViewStore(store) { store in
            HStack {
                Spacer()

                Button(
                    action: {
                        store.send(.skipBackward)
                    },
                    label: {
                        Image(systemName: "gobackward.15")
                            .resizable()
                            .modifier(ControlButtonModifier())
                    }
                )

                Spacer()

                Button(
                    action: {
                        store.send(.playback)
                    },
                    label: {
                        Image(systemName: store.state.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .modifier(ControlButtonModifier())
                    }
                )

                Spacer()

                Button(
                    action: {
                        store.send(.skipForward)
                    },
                    label: {
                        Image(systemName: "goforward.30")
                            .resizable()
                            .modifier(ControlButtonModifier())
                    }
                )

                Spacer()
            }
        }
    }
}

// MARK: ViewModifiers

private struct ControlButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 34, height: 34)
            .font(Font.title.weight(.medium))
    }
}
