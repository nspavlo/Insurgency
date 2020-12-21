//
//  StreamerUpdateViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 13/12/2020.
//

import Foundation

// MARK: Initialization

struct StreamerUpdateViewModel {
    static let kEmptyTimeField = "--:--"

    let streamer: AudioStreamer
    let formatter: DateComponentsFormatter
}

// MARK: Adapter

extension StreamerUpdateViewModel {
    var isPlaying: Bool {
        streamer.isPlaying
    }

    var volume: Float {
        streamer.volume
    }

    var progress: Float {
        Float(streamer.currentTime / streamer.duration)
    }

    var duration: String {
        if let duration = formatter.string(from: streamer.duration),
           streamer.duration > 0
        {
            return duration
        } else {
            return StreamerUpdateViewModel.kEmptyTimeField
        }
    }

    var remaining: String {
        if let remaining = formatter.string(from: streamer.duration - streamer.currentTime),
           streamer.duration - streamer.currentTime > 0
        {
            return "-\(remaining)"
        } else {
            return StreamerUpdateViewModel.kEmptyTimeField
        }
    }
}

// MARK: Convenience

extension StreamerInteractor.State {
    func updated(with instance: StreamerUpdateViewModel) -> StreamerInteractor.State {
        .init(
            isPlaying: instance.isPlaying,
            progress: instance.progress,
            duration: instance.duration,
            remaining: instance.remaining,
            volume: instance.volume,
            artworkURL: artworkURL,
            mediaURL: mediaURL,
            title: title,
            subtitle: subtitle
        )
    }
}
