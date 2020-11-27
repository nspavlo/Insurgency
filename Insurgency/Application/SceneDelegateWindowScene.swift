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

        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = UIHostingController(rootView: ContentView())
        window!.makeKeyAndVisible()
    }
}
