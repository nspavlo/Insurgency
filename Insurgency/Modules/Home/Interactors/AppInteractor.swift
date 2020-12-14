//
//  AppInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 14/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

struct AppInteractor {
    struct Environment {
        var podcasts: PodcastListInteractor.Environment
    }

    struct State: Equatable {
        var podcasts: PodcastListInteractor.State = .initial
    }

    enum Action: Equatable {
        case appear
        case podcasts(PodcastListInteractor.Action)
    }
}

// MARK: Reducer

extension AppInteractor {
    static func reducer() -> Reducer<State, Action, Environment> {
        .combine(
            .init { state, action, _ in
                switch action {
                case .appear:
                    state = .init()
                    return .none
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
