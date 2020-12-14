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
