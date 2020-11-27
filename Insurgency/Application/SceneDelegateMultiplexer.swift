//
//  SceneDelegateMultiplexer.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI

// MARK: Initialization

final class SceneDelegateMultiplexer: UIResponder {
    let delegates: [UIWindowSceneDelegate]

    init(delegates: [UIWindowSceneDelegate]) {
        self.delegates = delegates
    }
}

// MARK: UIWindowSceneDelegate

extension SceneDelegateMultiplexer: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options: UIScene.ConnectionOptions
    ) {
        delegates.forEach { $0.scene?(scene, willConnectTo: session, options: options) }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        delegates.forEach { $0.sceneDidDisconnect?(scene) }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        delegates.forEach { $0.sceneDidBecomeActive?(scene) }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        delegates.forEach { $0.sceneWillResignActive?(scene) }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        delegates.forEach { $0.sceneWillEnterForeground?(scene) }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        delegates.forEach { $0.sceneDidEnterBackground?(scene) }
    }
}
