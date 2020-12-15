//
//  PodcastListItemView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import SwiftUI

// MARK: Initialization

struct PodcastListItemView: View {
    let viewModel: PodcastListItemViewModel
}

// MARK: View Construction

extension PodcastListItemView {
    var body: some View {
        HStack {
            Image(symbol: viewModel.symbol)
                .foregroundColor(.secondary)

            Text(viewModel.title)
                .padding(.vertical, 8)
                .font(.body)
        }
    }
}

// MARK: PreviewProvider

struct PodcastListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PodcastListItemViewModel(
            podcast: Podcast(
                id: 1,
                name: "Name",
                feedURL: nil,
                artworkURL: URL(string: "https://http.cat/100")!
            )
        )
        PodcastListItemView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
