//
//  PodcastListLoaderView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import SwiftUI

// MARK: Initialization

struct PodcastListLoaderView: View {
    let text: String
}

// MARK: View Construction

extension PodcastListLoaderView {
    var body: some View {
        HStack {
            ActivityIndicator(
                isAnimating: true,
                style: .medium
            )
            Text(text)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}

// MARK: Preview

struct PodcastListLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastListLoaderView(text: "Loading...")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
