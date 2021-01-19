//
//  MediaControlView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import SwiftUI

// MARK: Initialization

struct MediaControlView: View {
    let store: Store<StreamerInteractor.State, StreamerInteractor.Action>
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
                        Image(symbol: .backward_15)
                            .resizable()
                            .modifier(ControlButtonModifier())
                    }
                )
                .disabled(store.isLoading)

                Spacer()

                Button(
                    action: {
                        store.send(.playback)
                    },
                    label: {
                        Image(symbol: store.state.isPlaying ? .pauseFill : .playFill)
                            .resizable()
                            .modifier(ControlButtonModifier())
                    }
                )
                .disabled(store.isLoading)

                Spacer()

                Button(
                    action: {
                        store.send(.skipForward)
                    },
                    label: {
                        Image(symbol: .forward_30)
                            .resizable()
                            .modifier(ControlButtonModifier())
                    }
                )
                .disabled(store.isLoading)

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
