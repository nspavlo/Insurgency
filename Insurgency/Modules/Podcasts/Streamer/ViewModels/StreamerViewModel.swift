//
//  StreamerViewModel.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 12/12/2020.
//

import Foundation
import AVFoundation

import Combine

// MARK: Initialization

final class StreamerViewModel: ObservableObject {
    @Published var time: String = "00:00"
    @Published var duration: String = "00:00"
    @Published var progress: CGFloat = 0
    @Published var volume: CGFloat = 1
    @Published var isPlaying: Bool = false

    private let episode: PodcastEpisode
    private var player: AVPlayer?
    private var timeObserverToken: Any?
    private var disposables = Set<AnyCancellable>()

    init(episode: PodcastEpisode) {
        self.episode = episode
    }
}

// MARK:

extension StreamerViewModel {
    var imageURL: URL { episode.image }
    var title: String { episode.title }
    var subtitle: String { episode.subtitle }
}

// MARK:

extension StreamerViewModel {
    func play() {
        let playerItem = AVPlayerItem(url: episode.stream)
        let player = AVPlayer(playerItem: playerItem)

        player.volume = 0.2
        player.play()

        self.player = player

        isPlaying = true
        volume = CGFloat(player.volume)

        $volume
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] volume in
                self?.player?.volume = Float(volume)
            }
            .store(in: &disposables)

        setupPeriodicTimeObserver()
    }

    func backward() {
        guard let time = player?.currentTime() else {
            return
        }

        var adjustedTimeInSeconds = CMTimeGetSeconds(time) - 15

        if adjustedTimeInSeconds < 0 {
            adjustedTimeInSeconds = 0
        }

        player?.seek(to: CMTimeMake(
            value: Int64(adjustedTimeInSeconds * 1000),
            timescale: 1000
        ))
    }

    func forward() {
        guard let time = player?.currentTime(),
              let duration = player?.currentItem?.duration else {
            return
        }

        let adjustedTimeInSeconds = CMTimeGetSeconds(time) + 30

        if adjustedTimeInSeconds < CMTimeGetSeconds(duration) {
            player?.seek(to: CMTimeMake(
                value: Int64(adjustedTimeInSeconds * 1000),
                timescale: 1000
            ))
        }
    }

    func pause() {
        isPlaying = false
        player?.pause()
    }

    func resume() {
        isPlaying = true
        player?.play()
    }

    func stop() {
        isPlaying = false
        player?.pause()
        removePeriodicTimeObserver()
        
        player = nil
    }

    func duration(for seconds: Double) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(Int(seconds)))
    }

    func setupPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?
            .addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                guard let asset = self?.player?.currentItem?.asset else {
                    return
                }

                self?.progress = CGFloat(time.seconds / asset.duration.seconds)

                if let time = self?.duration(for: asset.duration.seconds - time.seconds),
                   let duration = self?.duration(for: asset.duration.seconds)
                {
                    self?.time = "-\(time)"
                    self?.duration = duration
                }
        }
    }

    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
}
