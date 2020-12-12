//
//  StreamerView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import SwiftUI
import FetchImage

// MARK: Initialization

struct StreamerView: View {
    @ObservedObject
    var viewModel: StreamerViewModel
}

// MARK: View Construction

extension StreamerView {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                HStack {
                    Spacer()
                    sourceArtwork
                    Spacer()
                }
                .padding(.bottom, 36)

                VStack(alignment: .leading, spacing: 24) {
                    durationProgress
                    sourceName
                }

                Spacer()
                controlls
                Spacer()
                volume
                Spacer()
            }
            .padding([.leading, .trailing], 32)
        }
        .onAppear { viewModel.play() }
        .onDisappear { viewModel.stop() }
    }

    private var sourceArtwork: some View {
        AsyncImage(image: FetchImage(url: viewModel.imageURL))
            .frame(width: 260, height: 260)
            .cornerRadius(8)
            .shadow(color: Color(UIColor.tertiaryLabel), radius: 4, x: 0, y: 0)
    }

    private var durationProgress: some View {
        VStack {
            ProgressView(
                value: viewModel.progress,
                trackColor: Color(UIColor.tertiaryLabel),
                progressColor: Color(UIColor.secondaryLabel),
                height: 3)

            HStack {
                Text(viewModel.duration)
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.bold)

                Spacer()

                Text(viewModel.time)
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.bold)
            }
        }
    }

    private var sourceName: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.title)
                .foregroundColor(Color(UIColor.label))
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(alignment: .leading)

            Text(viewModel.subtitle)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .font(.title3)
                .fontWeight(.none)
                .lineLimit(1)
                .frame(alignment: .leading)
        }
    }

    private var controlls: some View {
        VStack {
            HStack {
                Spacer()

                Button(
                    action: {
                        viewModel.backward()
                    },
                    label: {
                        Image(systemName: "gobackward.15")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                            .font(Font.title.weight(.medium))
                    }
                )

                Spacer()

                Button(
                    action: {
                        viewModel.isPlaying
                            ? viewModel.pause()
                            : viewModel.resume()
                    },
                    label: {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                )

                Spacer()

                Button(
                    action: {
                        viewModel.forward()
                    },
                    label: {
                        Image(systemName: "goforward.30")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                            .font(Font.title.weight(.medium))
                    }
                )

                Spacer()
            }
        }
    }

    private var volume: some View {
        HStack(spacing: 8) {
            Image(systemName: "speaker.fill")
                .resizable()
                .foregroundColor(Color(UIColor.secondaryLabel))
                .aspectRatio(contentMode: .fit)
                .frame(width: 6, height: 10)

            Slider(value: $viewModel.volume, in: 0 ... 1)

            Image(systemName: "speaker.3.fill")
                .resizable()
                .foregroundColor(Color(UIColor.secondaryLabel))
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 14)
        }
    }
}

// MARK: Locale

private typealias Locale = String

private extension Locale {}
