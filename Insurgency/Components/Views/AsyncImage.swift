//
//  AsyncImage.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import SwiftUI
import FetchImage

// MARK: Initialization

// TODO:
// Remove dependency for `FetchImage`
// Use `URL` instead

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
                .aspectRatio(contentMode: .fit)
        }
        .animation(.default)
        .onAppear(perform: image.fetch)
        .onDisappear(perform: image.cancel)
    }
}
