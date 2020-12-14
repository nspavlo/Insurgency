//
//  MediaVolumeView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import SwiftUI

// MARK: Initialization

struct MediaVolumeView: View {
    var value: Binding<Float>
}

// MARK: View Construction

extension MediaVolumeView {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "speaker.fill")
                .resizable()
                .foregroundColor(.secondary)
                .aspectRatio(contentMode: .fit)
                .frame(width: 6, height: 10)

            Slider(
                value: value,
                in: 0 ... 1
            )

            Image(systemName: "speaker.3.fill")
                .resizable()
                .foregroundColor(.secondary)
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 14)
        }
    }
}
