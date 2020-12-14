//
//  StreamerView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import Combine
import ComposableArchitecture
import SwiftUI
import FetchImage

// MARK: Initialization

struct StreamerView: View {
    let store: Store<StreamerViewModel.State, StreamerViewModel.Action>
}

// MARK: View Construction

extension StreamerView {
    var body: some View {
        WithViewStore(store) { store in
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    HStack {
                        Spacer()
                        sourceArtwork(with: store.state)
                        Spacer()
                    }
                    .frame(height: 280)
                    .padding(.bottom, 16)

                    sourceMediaState()

                    Spacer()

                    MediaControlView(store: self.store)

                    Spacer()

                    MediaVolumeView(
                        value: store.binding(
                            get: { state in state.volume },
                            send: StreamerViewModel.Action.changeVolume
                        )
                    )

                    Spacer()
                }
                .padding([.leading, .trailing], 32)
            }
            .onAppear { store.send(.appear) }
            .onDisappear { store.send(.disappear) }
        }
    }

    @ViewBuilder
    private func sourceArtwork(with state: StreamerViewModel.State) -> some View {
        AsyncImage(image: FetchImage(url: state.artworkURL))
            .frame(
                width: state.isPlaying ? 280 : 260,
                height: state.isPlaying ? 280 : 260
            )
            .cornerRadius(8)
            .shadow(
                color: Color(UIColor.tertiaryLabel),
                radius: 4, x: 0, y: 0
            )
            .animation(.default)
    }

    @ViewBuilder
    private func sourceMediaState() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            MediaTimingView(store: self.store)
            MediaNameView(store: self.store)
        }
    }
}
