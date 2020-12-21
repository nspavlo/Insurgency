//
//  AudioStreamer.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import AVFoundation

// MARK: Initialization

final class AudioStreamer {
    var volume: Float = 0.8 {
        didSet {
            player?.volume = volume
        }
    }

    var isPlaying: Bool {
        if let player = player {
            return player.rate != 0
        } else {
            return false
        }
    }

    var duration: Double {
        if let seconds = player?.currentItem?.duration.seconds, seconds.isFinite {
            return seconds
        } else {
            return 0
        }
    }

    var currentTime: Double {
        get {
            if let player = player {
                return CMTimeGetSeconds(player.currentTime())
            } else {
                return 0
            }
        }
        set {
            guard let timescale = player?.currentItem?.duration.timescale else {
                return
            }

            let time = CMTimeMakeWithSeconds(newValue, preferredTimescale: timescale)
            player?.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
        }
    }

    private var player: AVPlayer?

    deinit {
        stop()
    }
}

// MARK: Playback Controls

extension AudioStreamer {
    func play(_ url: URL) {
        player = AVPlayer(playerItem: AVPlayerItem(url: url))
        player?.volume = volume

        resume()
    }

    func pause() {
        player?.rate = 0
    }

    func resume() {
        player?.rate = 1
    }

    func stop() {
        pause()
        player = nil
    }
}

// MARK: Seeking

extension AudioStreamer {
    func forward() {
        currentTime = min(currentTime + 30, duration)
    }

    func backward() {
        currentTime = max(currentTime - 15, 0)
    }
}
