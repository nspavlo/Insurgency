//
//  SceneDelegateLogger.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import SwiftUI
import OSLog

// MARK: Initialization

final class SceneDelegateLogger: UIResponder {
    let logger = Logger(category: "WindowScene")
    let emoji = "🎬"
}

// MARK: UIWindowSceneDelegate

extension SceneDelegateLogger: UIWindowSceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        logger.info("[\(self.emoji)] Connect: \(self.message(for: scene))")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        logger.info("[\(self.emoji)] Disconnect: \(self.message(for: scene))")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        logger.info("[\(self.emoji)] Become Active: \(self.message(for: scene))")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        logger.info("[\(self.emoji)] Resign Active: \(self.message(for: scene))")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        logger.info("[\(self.emoji)] Foreground: \(self.message(for: scene))")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        logger.info("[\(self.emoji)] Background: \(self.message(for: scene))")
    }
}

// MARK: Private Methods

private extension SceneDelegateLogger {
    func message(for scene: UIScene) -> String {
        scene.session.persistentIdentifier
    }
}
