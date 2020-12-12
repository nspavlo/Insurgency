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

    @State
    private var appeared = false

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
                    .frame(width: (geomery.size.width * value) > 0 && appeared
                        ? max(height, geomery.size.width * value)
                        : 0)
            }
        }
        .onAppear(perform: {
            appeared = true
        })
        .frame(height: height)
        .background(Color.clear)
    }
}
