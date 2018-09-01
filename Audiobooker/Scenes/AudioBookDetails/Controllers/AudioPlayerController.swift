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
        return self.audioPlayer.loadedURL
    }


    private weak var playerView: (UIView & IPlayerView)!

    private weak var delegate: IAudioPlayerDelegate?

    private var audioPlayer: IAudioPlayer

    private var paused = true
    
    required init(playerView: UIView & IPlayerView,
                  delegate: IAudioPlayerDelegate,
                  audioPlayer: IAudioPlayer) {
        self.playerView = playerView
        self.delegate = delegate
        self.audioPlayer = audioPlayer
    }
    
    func viewIsReady() {
        UIViewDecorator.decorate(view: playerView, config: .player)
        
        self.playerView.delegate = self
        
        self.audioPlayer.subscribeForProgress { [weak self] (progress) in
            self?.progressChanged(to: progress)
        }
    }
    
    func loadFile(url: URL) {
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
}

extension AudioPlayerController: IPlayerViewDelegate {
    func playTapped() {
        self.paused = !self.paused
        self.paused ? self.audioPlayer.pause() : self.audioPlayer.play()
        self.playerView.paused = self.paused
    }
    
    func nextTapped() {
        guard   let url = self.audioPlayer.loadedURL,
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
        guard   let url = self.audioPlayer.loadedURL,
                let previousURL = self.delegate?.getPreviousFileURL(for: url) else {
                    assertionFailure()
                    return
        }
        
        self.loadFile(url: previousURL)
        if !paused {
            self.startPlaying()
        }
    }
    
    func roll(seconds: Double) {
        audioPlayer.roll(seconds: seconds)
    }
}

private extension AudioPlayerController {
    func progressChanged(to progress: Float) {
        self.playerView?.set(progress: progress)
    }
}
