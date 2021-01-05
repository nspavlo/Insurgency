//
//  SceneDelegate.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI

// MARK: Initialization

class SceneDelegate: UIResponder {
    let multiplexer = SceneDelegateMultiplexer(delegates: [
        SceneDelegateWindowScene(),
        SceneDelegateLogger()
    ])
}

// MARK: UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options: UIScene.ConnectionOptions
    ) {
        multiplexer.scene(scene, willConnectTo: session, options: options)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        multiplexer.sceneDidDisconnect(scene)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        multiplexer.sceneDidBecomeActive(scene)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        multiplexer.sceneWillResignActive(scene)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        multiplexer.sceneWillEnterForeground(scene)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        multiplexer.sceneDidEnterBackground(scene)
    }
}
