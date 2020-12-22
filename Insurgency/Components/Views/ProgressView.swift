//
//  ProgressView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import SwiftUI

// MARK: Initialization

struct ProgressView: View {
    let value: CGFloat
    let trackColor: Color
    let progressColor: Color
    let height: CGFloat

    init(
        value: CGFloat,
        trackColor: Color,
        progressColor: Color,
        height: CGFloat
    ) {
        self.value = value
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.height = height
    }
}

// MARK: View Construction

extension ProgressView {
    var body: some View {
        ZStack {
            GeometryReader { geomery in
                Capsule()
                    .foregroundColor(trackColor.opacity(0.2))
                    .frame(width: geomery.size.width)

                Capsule()
                    .foregroundColor(progressColor)
                    .frame(width: (geomery.size.width * value) > 0
                        ? max(height, geomery.size.width * value)
                        : 0)
            }
        }
        .frame(height: height)
        .background(Color.clear)
    }
}

// MARK: PreviewProvider

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(
            value: 0.8,
            trackColor: .secondary,
            progressColor: .red,
            height: 2
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
