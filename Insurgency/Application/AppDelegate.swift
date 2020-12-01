//
//  AppDelegate.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 27/11/2020.
//

import UIKit
import Combine

// MARK: Initialization

@main
class AppDelegate: NSObject {
    private var operation: AnyCancellable?

    private func execute(with options: [UIApplication.LaunchOptionsKey: Any]?) {
        AppDelegateCommandBuilder()
            .setupLaunchingOptions(options)
            .make()
            .execute()
    }

    private func playground() {
        let host: URLHost = .production
        let repository = PodcastRepository(session: .shared, url: host.url, queue: .main)
        operation = repository.fetchPodcasts(with: "swift")
            .sink {
                print("**** State: \($0)")
            } receiveValue: { podcasts in
                print("**** Podcasts: \(podcasts)")
            }
    }
}

// MARK: UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        execute(with: options)
        playground()
        return true
    }
}
