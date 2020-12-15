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
    private var image: FetchImage
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

// MARK: Convenience

extension AsyncImage {
    init(url: URL) {
        self.init(image: FetchImage(url: url))
    }
}

// MARK: PreviewProvider

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "https://http.cat/100")!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
