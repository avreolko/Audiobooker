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
    private var paused = false
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
    
    func playFile(url: URL) {
        let asset = AVAsset(url: url)
        self.asset = asset
        audioPlayer.replaceCurrentItem(with: AVPlayerItem(asset: asset))
        audioPlayer.play()
    }
    
    private func checkProgress(cmtime: CMTime) {
        guard let asset = self.asset else { return }
        
        let playedSeconds = CMTimeGetSeconds(cmtime)
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        
        let progress: Float = Float(playedSeconds / durationSeconds)
        self.playerView?.set(progress: progress)
    }
}

extension AudioPlayerController: IChaptersListControllerDelegate {
    func select(chapter: Chapter) {
        self.playFile(url: chapter.audioFilePath)
    }
}

extension AudioPlayerController: IPlayerViewDelegate {
    func playTapped() {
        self.paused = !self.paused
        self.paused ? self.audioPlayer.pause() : self.audioPlayer.play()
        self.playerView?.paused = self.paused
    }
    
    func nextTapped() {
        
    }
    
    func previousTapped() {
        
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
