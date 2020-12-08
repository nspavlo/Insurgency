//
//  SceneDelegateWindowScene.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI
import ComposableArchitecture

// MARK: Initialization

final class SceneDelegateWindowScene: UIResponder {
    var window: UIWindow?
}

// MARK: UIWindowSceneDelegate

extension SceneDelegateWindowScene: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let host: URLHost = .production
        let repository = PodcastRepository(
            session: .shared,
            url: host.url,
            queue: .main
        )

        let rootView = PodcastSearchListView(
            store: Store(
                initialState: PodcastSearchViewModel.State.initial,
                reducer: PodcastSearchViewModel.reducer().debug(),
                environment: PodcastSearchViewModel.Environment(
                    repository: repository,
                    queue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )

        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = UIHostingController(rootView: rootView)
        window!.makeKeyAndVisible()
    }
}
