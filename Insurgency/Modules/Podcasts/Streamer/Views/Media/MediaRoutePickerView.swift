//
//  MediaRoutePickerView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/01/2021.
//

import AVKit
import SwiftUI

struct MediaRoutePickerView: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIView {
        AVRoutePickerView()
    }

    func updateUIView(_: UIView, context _: Context) {}
}
