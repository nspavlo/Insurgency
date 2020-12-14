//
//  Symbol.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import Foundation
import SwiftUI

// MARK: Initialization

enum Symbol: String {
    case backward_15 = "gobackward.15"
    case forward_30 = "goforward.30"
    case pauseFill = "pause.fill"
    case playFill = "play.fill"
    case search = "magnifyingglass"
    case speakerMaxFill = "speaker.3.fill"
    case speakerMinFill = "speaker.fill"

    var systemName: String { rawValue }
}

// MARK: Image+Symbol

extension Image {
    init(symbol: Symbol) {
        self.init(systemName: symbol.systemName)
    }
}
