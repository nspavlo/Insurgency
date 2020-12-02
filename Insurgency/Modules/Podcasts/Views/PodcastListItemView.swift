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
            Image(systemName: viewModel.imageName)
                .foregroundColor(Color(UIColor.secondaryLabel))

            Text("\(viewModel.title)")
                .padding(.vertical, 8)
                .font(.body)
        }
    }
}

// MARK: Preview

struct PodcastListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let podcast = Podcast(
            trackID: 1,
            trackName: "John Snow",
            feedURL: nil
        )
        return PodcastListItemView(viewModel: PodcastListItemViewModel(podcast: podcast))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
