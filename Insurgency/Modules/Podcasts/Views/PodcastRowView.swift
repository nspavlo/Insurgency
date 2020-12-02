//
//  PodcastRowView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 02/12/2020.
//

import SwiftUI

// MARK: Initialization

struct PodcastRowView: View {
    let viewModel: PodcastRowViewModel

    init(viewModel: PodcastRowViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: View Construction

extension PodcastRowView {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(UIColor.opaqueSeparator))

            Text("\(viewModel.title)")
                .padding(.vertical, 8)
                .font(.callout)
        }
    }
}

// MARK: Preview

struct PodcastRowView_Previews: PreviewProvider {
    static var previews: some View {
        let podcast = Podcast(
            trackId: 1,
            artistName: "John Snow",
            feedUrl: nil
        )
        return PodcastRowView(viewModel: PodcastRowViewModel(podcast: podcast))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
