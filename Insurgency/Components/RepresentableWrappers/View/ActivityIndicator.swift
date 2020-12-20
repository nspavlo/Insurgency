//
//  ActivityIndicator.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 03/12/2020.
//

import SwiftUI

// MARK: Initialization

struct ActivityIndicator {
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style
}

// MARK: UIViewRepresentable

extension ActivityIndicator: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        return spinner
    }

    func updateUIView(_ view: UIActivityIndicatorView, context _: Context) {
        if isAnimating {
            view.startAnimating()
        } else {
            view.stopAnimating()
        }
    }
}
