//
//  ListLoaderView.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import SwiftUI

// MARK: Initialization

struct ListLoaderView: View {
    let text: String
}

// MARK: View Construction

extension ListLoaderView {
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

struct ListLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListLoaderView(text: "Loading...")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
