//
//  SceneDelegateLogger.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI

// MARK: Initialization

final class SceneDelegateLogger: UIResponder {
    let id = "🎬"
}

// MARK: UIWindowSceneDelegate

extension SceneDelegateLogger: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options: UIScene.ConnectionOptions
    ) {
        print("**** [\(id)] Connect: \(message(for: scene))")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("**** [\(id)] Disconnect: \(message(for: scene))")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("**** [\(id)] Become Active: \(message(for: scene))")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("**** [\(id)] Resign Active: \(message(for: scene))")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("**** [\(id)] Foreground: \(message(for: scene))")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("**** [\(id)] Background: \(message(for: scene))")
    }
}

// MARK: Private Methods

private extension SceneDelegateLogger {
    func message(for scene: UIScene) -> String {
        scene.session.persistentIdentifier
    }
}
