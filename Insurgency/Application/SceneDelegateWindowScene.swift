//
//  SceneDelegateWindowScene.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI

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
        window = (scene as? UIWindowScene)
            .map(UIWindow.init(windowScene:))

        window?.rootViewController = UIHostingController(
            rootView: TabBarView(
                store: .init(
                    initialState: .init(),
                    reducer: AppInteractor.reducer().debug(),
                    environment: .init(
                        podcasts: .init(
                            repository: PodcastRepository(
                                session: .shared,
                                url: URLHost.production.url,
                                queue: .main
                            ),
                            queue: DispatchQueue.main.eraseToAnyScheduler()
                        )
                    )
                )
            )
        )
        window?.tintColor = .systemPink
        window?.makeKeyAndVisible()
    }
}
