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

                    VStack(alignment: .leading, spacing: 24) {
                        sourceTiming(with: store.state)
                        sourceName(with: store.state)
                    }

                    Spacer()

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
    private func sourceTiming(with state: StreamerViewModel.State) -> some View {
        VStack {
            ProgressView(
                value: CGFloat(state.progress),
                trackColor: Color(UIColor.tertiaryLabel),
                progressColor: .secondary,
                height: 3)

            HStack {
                Text(state.duration)
                    .modifier(MonospacedLabelModifier())

                Spacer()

                Text(state.remaining)
                    .modifier(MonospacedLabelModifier())
            }
        }
    }

    @ViewBuilder
    private func sourceName(with state: StreamerViewModel.State) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(state.title)
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(alignment: .leading)

            Text(state.subtitle)
                .foregroundColor(.secondary)
                .font(.title3)
                .fontWeight(.none)
                .lineLimit(1)
                .frame(alignment: .leading)
        }
    }
}

// MARK: ViewModifiers

struct MonospacedLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(UIColor.tertiaryLabel))
            .font(Font.system(.caption, design: .monospaced).weight(.bold))
    }
}

struct ControlButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 34, height: 34)
            .font(Font.title.weight(.medium))
    }
}
