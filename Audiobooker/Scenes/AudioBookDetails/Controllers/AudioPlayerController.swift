//
//  AudioPlayerController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerController: NSObject, IAudioPlayerController {
    private weak var playerView: (UIView & IPlayerView)!
    private var audioPlayer: AudioPlayer
    private var paused = true
    private var asset: AVAsset?
    
    weak var delegate: IAudioPlayerDelegate?
    
    required init(playerView: UIView & IPlayerView,
                  delegate: IAudioPlayerDelegate,
                  audioPlayer: AudioPlayer) {
        self.playerView = playerView
        self.delegate = delegate
        self.audioPlayer = audioPlayer // TODO добавить абстракцию от AVPlayer
    }
    
    func viewIsReady() {
        UIViewDecorator.decorate(view: playerView, config: .player)
        
        self.playerView.delegate = self
        self.audioPlayer.progressClosures.append { [weak self] (progress) in
            self?.progressChanged(to: progress)
        }
    }
    
    func loadFile(url: URL) {
        let asset = AVAsset(url: url)
        self.asset = asset
        self.audioPlayer.loadFile(url: url)
        playerView.set(progress: 0, animated: false)
        
        let mp3TagContainer = MP3TagContainer(pathToMP3File: url)
        self.playerView?.set(title: mp3TagContainer.title)
    }
    
    func startPlaying() {
        audioPlayer.play()
        self.paused = false
        self.playerView?.paused = self.paused
    }
    
    func stopPlaying() {
        audioPlayer.pause()
        self.paused = true
        self.playerView?.paused = self.paused
    }
    
    var progress: Float {
        get {
            print("progress: \(self.audioPlayer.progress)")
            return self.audioPlayer.progress
        }
        set {
            self.playerView.set(progress: newValue, animated: true)
            self.audioPlayer.progress = newValue
        }
    }
    
    var fileURL: URL? {
        guard let url = (self.asset as? AVURLAsset)?.url else {
            return nil
        }
        
        return url
    }
}

extension AudioPlayerController: IPlayerViewDelegate {
    func playTapped() {
        self.paused = !self.paused
        self.paused ? self.audioPlayer.pause() : self.audioPlayer.play()
        self.playerView.paused = self.paused
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

private extension AudioPlayerController {
    func progressChanged(to progress: Float) {
        self.playerView?.set(progress: progress)
    }
}
