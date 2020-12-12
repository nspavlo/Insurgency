//
//  StreamerViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import ComposableArchitecture
import Foundation

// MARK: Initialization

struct StreamerViewModel {
    struct Environment {
        let episode: PodcastEpisode
        let streamer: AudioStreamer
    }

    struct State: Equatable {
        var isPlaying: Bool
        var progress: Float
        var duration: String
        var remaining: String
        var volume: Float
        var image: URL
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

extension StreamerViewModel {
    static func reducer() -> Reducer<State, Action, Environment> {
        .init { state, action, environment in
            struct TimerID: Hashable {}

            let streamerUpdateFromTimer = Effect
                .timer(id: TimerID(), every: 0.25, on: RunLoop.main)
                .map { _ in Action.updateFromStreamer }

            let updateFromStreamer = Effect<Action, Never>(value: .updateFromStreamer)

            switch action {
            case .appear:
                environment.streamer.play()
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

// MARK: Store

extension StreamerViewModel {
    static func store(with environment: Environment) -> Store<State, Action> {
        let state = State(
            isPlaying: false,
            progress: 0.0,
            duration: StreamerUpdateViewModel.kEmptyTimeField,
            remaining: StreamerUpdateViewModel.kEmptyTimeField,
            volume: 0.8,
            image: environment.episode.image,
            title: environment.episode.title,
            subtitle: environment.episode.subtitle
        )

        return .init(
            initialState: state,
            reducer: reducer().debug(),
            environment: environment
        )
    }
}
