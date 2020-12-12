//
//  PodcastEpisodeListItemView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import SwiftUI
import FetchImage

// MARK: Initialization

struct PodcastEpisodeListItemView: View {
    let viewModel: PodcastEpisodeListItemViewModel
}

// MARK: View Construction

extension PodcastEpisodeListItemView {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(image: FetchImage(url: viewModel.image))
                .cornerRadius(8)
                .frame(width: 64, height: 64)

            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.date)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(1)

                Text("\(viewModel.title)")
                    .font(.body)
                    .lineLimit(2)

                Text("\(viewModel.subtitle)")
                    .font(.caption)
                    .lineLimit(2)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}
