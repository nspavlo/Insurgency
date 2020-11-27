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
        print("**** [\(id)] Connect: \(scene.session.persistentIdentifier)")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("**** [\(id)] Disconnect: \(scene.session.persistentIdentifier)")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("**** [\(id)] Become Active: \(scene.session.persistentIdentifier)")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("**** [\(id)] Resign Active: \(scene.session.persistentIdentifier)")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("**** [\(id)] Foreground: \(scene.session.persistentIdentifier)")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("**** [\(id)] Background: \(scene.session.persistentIdentifier)")
    }
}
