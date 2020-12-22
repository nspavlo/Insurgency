//
//  StreamerInteractor.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

enum StreamerInteractor {
    struct Environment {
        let streamer: AudioStreamer
    }

    struct State: Equatable {
        var isLoading = true
        var isPlaying = false
        var progress: Float = 0.0
        var duration: String
        var remaining: String
        var volume: Float = 0.0
        var artworkURL: URL
        var mediaURL: URL
        var title: String
        var subtitle: String
    }

    enum Action: Equatable {
        case appear
        case disappear
        case skipForward
        case skipBackward
        case playback
        case changeVolume(Float)
        case updateFromStreamer
    }
}

// MARK: Reducer

extension StreamerInteractor {
    static func reducer() -> Reducer<State, Action, Environment> {
        .init { state, action, environment in
            struct TimerID: Hashable {}

            let streamerUpdateFromTimer = Effect
                .timer(id: TimerID(), every: 0.5, on: RunLoop.main)
                .map { _ in Action.updateFromStreamer }

            let updateFromStreamer = Effect<Action, Never>(value: .updateFromStreamer)

            switch action {
            case .appear:
                environment.streamer.play(state.mediaURL)
                return streamerUpdateFromTimer
            case .disappear:
                environment.streamer.stop()
                return .cancel(id: TimerID())
            case .skipForward:
                environment.streamer.forward()
                return updateFromStreamer
            case .skipBackward:
                environment.streamer.backward()
                return updateFromStreamer
            case .playback:
                if state.isPlaying {
                    environment.streamer.pause()
                    return .merge(
                        .cancel(id: TimerID()),
                        updateFromStreamer
                    )
                } else {
                    environment.streamer.resume()
                    return .merge(
                        streamerUpdateFromTimer,
                        updateFromStreamer
                    )
                }
            case .changeVolume(let volume):
                environment.streamer.volume = volume
                return updateFromStreamer
            case .updateFromStreamer:
                let instance =
                    StreamerUpdateViewModel(
                        streamer: environment.streamer,
                        formatter: .durationDateComponentsFormatter
                    )
                state = state.updated(with: instance)
                return .none
            }
        }
    }
}
