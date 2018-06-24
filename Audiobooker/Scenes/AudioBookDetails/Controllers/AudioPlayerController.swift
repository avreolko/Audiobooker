//
//  AudioPlayerController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerController: IAudioPlayerController {
    private weak var playerView: IPlayerView?
    weak var delegate: IAudioPlayerDelegate?
    private var audioPlayer: AVPlayer
    private var paused = true
    private var asset: AVAsset?
    private var _progress: Float = 0
    
    required init(playerView: IPlayerView) {
        self.playerView = playerView
        self.audioPlayer = AVPlayer() // TODO добавить абстракцию от AVPlayer
        self.playerView?.delegate = self
        
        let cmtime = CMTime(seconds: 0.2, preferredTimescale: Int32(44100))
        self.audioPlayer.addPeriodicTimeObserver(forInterval: cmtime, queue: .main) { (time) in
            self.checkProgress(cmtime: cmtime)
        }
    }
    
    var progress: Float {
        return _progress
    }
    
    func loadFile(url: URL) {
        let asset = AVAsset(url: url)
        self.asset = asset
        audioPlayer.replaceCurrentItem(with: AVPlayerItem(asset: asset))
        playerView?.set(progress: 0, animated: false)
        
        let mp3TagContainer = MP3TagContainer(pathToMP3File: url)
        self.playerView?.set(title: mp3TagContainer.title)
    }
    
    func startPlaying() {
        audioPlayer.play()
    }
    
    private func checkProgress(cmtime: CMTime) {
        guard let currentItem = self.audioPlayer.currentItem else {
            return
        }
        
        let currentTime = currentItem.currentTime()
        let duration = currentItem.duration

        let playedSeconds = CMTimeGetSeconds(currentTime)
        let durationSeconds = CMTimeGetSeconds(duration)

        
        if playedSeconds >= 0, durationSeconds > 0 {
            let progress: Float = Float(playedSeconds / durationSeconds)
            self.playerView?.set(progress: progress)
        }
    }
}

extension AudioPlayerController: IPlayerViewDelegate {
    func playTapped() {
        self.paused = !self.paused
        self.paused ? self.audioPlayer.pause() : self.audioPlayer.play()
        self.playerView?.paused = self.paused
    }
    
    func nextTapped() {
        guard let url = (self.asset as? AVURLAsset)?.url,
        let nextURL = self.delegate?.getNextFileURL(for: url) else {
            assertionFailure()
            return
        }
        
        self.loadFile(url: nextURL)
        if !paused {
            self.startPlaying()
        }
    }
    
    func previousTapped() {
        guard let url = (self.asset as? AVURLAsset)?.url,
            let previousURL = self.delegate?.getPreviousFileURL(for: url) else {
                assertionFailure()
                return
        }
        
        self.loadFile(url: previousURL)
        if !paused {
            self.startPlaying()
        }
    }
}

extension AudioPlayerController: IStateable {
    var state: Codable? {
        guard let url = (self.asset as? AVURLAsset)?.url else {
            return nil
        }
        
        return AudioPlayerControllerState(progress: self.progress, assetURL: url)
    }
    
    var key: String { return "audio player controller state" }
    
    func restore(with state: Codable?) {
        guard let state = state as? AudioPlayerControllerState else {
            return
        }
        
        _progress = state.progress
        self.asset = AVAsset(url: state.assetURL)
    }
}

struct AudioPlayerControllerState: Codable {
    var progress: Float
    var assetURL: URL
}
