//
//  View+Erase.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 08/12/2020.
//

import SwiftUI

// MARK: View+Erase

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
