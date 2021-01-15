//
//  AudioStreamer.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import AVFoundation

// MARK: Initialization

final class AudioStreamer {
    enum StreamError: Error {
        case unknown
        case cancelled
        case failed(underlyingError: NSError?)
    }

    var error: StreamError?

    var volume: Float = 0.8 {
        didSet {
            player?.volume = volume
        }
    }

    var isLoading: Bool {
        player?.status != .readyToPlay
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
        let asset = AVAsset(url: url)
        let keys = ["playable"]

        error = nil
        asset.loadValuesAsynchronously(forKeys: keys) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                for key in keys {
                    var error: NSError?

                    switch asset.statusOfValue(forKey: key, error: &error) {
                    case .loaded:
                        self?.play(asset)
                    case .failed:
                        self?.error = .failed(underlyingError: error)
                    case .cancelled:
                        self?.error = .cancelled
                    default:
                        self?.error = .unknown
                    }
                }
            }
        }
    }

    func play(_ asset: AVAsset) {
        player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
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
        let interval = 30.0
        currentTime = min(currentTime + interval, duration)
    }

    func backward() {
        let interval = 15.0
        currentTime = max(currentTime - interval, 0)
    }
}
