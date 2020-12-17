//
//  AppInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

enum AppInteractor {
    struct Environment {
        let podcasts: PodcastListInteractor.Environment
    }

    struct State: Equatable {
        var podcasts: PodcastListInteractor.State = .initial
    }

    enum Action: Equatable {
        case podcasts(PodcastListInteractor.Action)
    }
}

// MARK: Reducer

extension AppInteractor {
    static func reducer() -> Reducer<State, Action, Environment> {
        .combine(
            .init { state, action, _ in
                switch action {
                case .podcasts:
                    return .none
                }
            },
            PodcastListInteractor.reducer()
                .pullback(
                    state: \.podcasts,
                    action: /AppInteractor.Action.podcasts,
                    environment: { $0.podcasts }
                )
        )
    }
}
