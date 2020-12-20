//
//  SceneDelegateLogger.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI

// MARK: Initialization

final class SceneDelegateLogger: UIResponder {
    let emoji = "🎬"
}

// MARK: UIWindowSceneDelegate

extension SceneDelegateLogger: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        print("**** [\(emoji)] Connect: \(message(for: scene))")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("**** [\(emoji)] Disconnect: \(message(for: scene))")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("**** [\(emoji)] Become Active: \(message(for: scene))")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("**** [\(emoji)] Resign Active: \(message(for: scene))")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("**** [\(emoji)] Foreground: \(message(for: scene))")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("**** [\(emoji)] Background: \(message(for: scene))")
    }
}

// MARK: Private Methods

private extension SceneDelegateLogger {
    func message(for scene: UIScene) -> String {
        scene.session.persistentIdentifier
    }
}
