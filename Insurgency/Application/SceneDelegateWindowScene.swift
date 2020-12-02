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
        guard let windowScene = scene as? UIWindowScene else { return }

        let host: URLHost = .production
        let repository = PodcastRepository(
            session: .shared,
            url: host.url,
            queue: .main
        )

        let viewModel = PodcastListViewModel(
            repository: repository,
            scheduler: DispatchQueue(label: "me.insurgency.podcast.viewModel")
        )

        let rootView = PodcastListView(viewModel: viewModel)

        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = UIHostingController(rootView: rootView)
        window!.makeKeyAndVisible()
    }
}
