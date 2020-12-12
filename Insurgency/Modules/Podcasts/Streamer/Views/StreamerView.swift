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
    @State private var value: Double = 0.8
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
    }

    private var sourceArtwork: some View {
        AsyncImage(image: FetchImage(url: URL(string: "https://www.swiftbysundell.com/images/podcastArtwork.png")!))
            .frame(width: 260, height: 260)
            .cornerRadius(8)
            .shadow(color: Color(UIColor.tertiaryLabel), radius: 4, x: 0, y: 0)
    }

    private var durationProgress: some View {
        VStack {
            ProgressView(
                value: CGFloat(0.8),
                trackColor: Color(UIColor.tertiaryLabel),
                progressColor: Color(UIColor.secondaryLabel),
                height: 3)

            HStack {
                Text("1:38:30")
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .font(.caption)
                    .fontWeight(.bold)

                Spacer()

                Text("-26:48")
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .font(.caption)
                    .fontWeight(.bold)
            }
        }
    }

    private var sourceName: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("251. Training without events")
                .foregroundColor(Color(UIColor.label))
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
                .frame(alignment: .leading)

            Button(
                action: {},
                label: {
                    Text("Ask a Cycling Coach - TrainerRoad")
                        .font(.title3)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(alignment: .leading)
                }
            )
        }
    }

    private var controlls: some View {
        VStack {
            HStack {
                Spacer()

                Button(
                    action: {},
                    label: {
                        Image(systemName: "gobackward.15")
                            .resizable()
                            .foregroundColor(Color(UIColor.label))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                            .font(Font.title.weight(.medium))
                    }
                )

                Spacer()

                Button(
                    action: {},
                    label: {
                        Image(systemName: "play.fill")
                            .resizable()
                            .foregroundColor(Color(UIColor.label))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                )

                Spacer()

                Button(
                    action: {},
                    label: {
                        Image(systemName: "goforward.30")
                            .resizable()
                            .foregroundColor(Color(UIColor.label))
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

            Slider(value: $value, in: 0 ... 1)

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
