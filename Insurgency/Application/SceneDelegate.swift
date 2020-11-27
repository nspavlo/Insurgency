//
//  SceneDelegate.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI

// MARK: Initialization

class SceneDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window!.rootViewController = UIHostingController(rootView: ContentView())
            window!.makeKeyAndVisible()
        }
    }
}
