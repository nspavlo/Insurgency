//
//  StreamerView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import ComposableArchitecture
import SwiftUI

// MARK: Initialization

struct StreamerView: View {
    let store: Store<StreamerInteractor.State, StreamerInteractor.Action>
}

// MARK: View Construction

// TODO:
// Extract artwork to `MediaArtworkView`

extension StreamerView {
    var body: some View {
        GeometryReader { geometry in
            WithViewStore(store) { store in
                VStack(alignment: .leading, spacing: 16) {
                    sourceArtwork(with: store.state, geometry: geometry)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .padding(.bottom, 16)

                    MediaTimingView(store: self.store)
                    MediaNameView(store: self.store)

                    Spacer()

                    MediaControlView(store: self.store)

                    Spacer()

                    MediaVolumeView(
                        value: store.binding(
                            get: { state in state.volume },
                            send: StreamerInteractor.Action.changeVolume
                        )
                    )

                    Spacer()
                }
                .onAppear { store.send(.appear) }
                .onDisappear { store.send(.disappear) }
            }
        }
        .padding([.top, .leading, .trailing, .bottom], 32)
    }

    @ViewBuilder
    private func sourceArtwork(
        with state: StreamerInteractor.State,
        geometry: GeometryProxy
    ) -> some View {
        HStack {
            Spacer()

            AsyncImage(url: state.artworkURL)
                .frame(
                    width: state.isPlaying
                        ? geometry.size.width
                        : geometry.size.width * 0.8,
                    height: state.isPlaying
                        ? geometry.size.width
                        : geometry.size.width * 0.8
                )
                .cornerRadius(8)
                .shadow(
                    color: Color(UIColor.tertiaryLabel),
                    radius: 4, x: 0, y: 0
                )
                .animation(.default)

            Spacer()
        }
    }
}
