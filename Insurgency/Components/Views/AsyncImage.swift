//
//  AsyncImage.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import SwiftUI
import FetchImage

// MARK: Initialization

struct AsyncImage: View {
    @ObservedObject
    var image: FetchImage
}

// MARK: View Construction

extension AsyncImage {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))

            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .animation(.default)
        .onAppear {
            image.priority = .normal
            image.fetch()
        }
        .onDisappear {
            image.priority = .low
        }
    }
}
