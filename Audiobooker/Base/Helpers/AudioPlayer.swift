//
//  AudioPlayer.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
import AVFoundation

protocol IAudioPlayer {
    func loadFile(url: URL)
    func play()
    func pause()
    var progress: Float { get set }
}

protocol AudioPlayerDelegate: AnyObject {
    func progressChanged(to: Float)
}

class AudioPlayer {
    static let shared: AudioPlayer = AudioPlayer()
    
    private var player: AVAudioPlayer?
    public weak var delegate: AudioPlayerDelegate?
    
    typealias ProgressClosure = (Float) -> ()
    public var progressClosures: [ProgressClosure] = [ProgressClosure]()
    
    private let refreshTime = 0.2
    private var timer: Timer? = nil
    
    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: refreshTime,
                                          repeats: true,
                                          block: { [weak self] (timer) in
            self?.executeProgressClosures()
        })
    }
}

extension AudioPlayer: IAudioPlayer {
    func loadFile(url: URL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    // TODO переписать покрасивше
    var progress: Float {
        get {
            guard
                let currentTime = player?.currentTime,
                let durationTime = player?.duration else {
                return 0
            }
            
            return Float(currentTime / durationTime)
        }
        set {
            guard let durationTime = player?.duration else {
                    return
            }
            player?.currentTime = TimeInterval(TimeInterval(newValue) * durationTime)
        }
    }
}

private extension AudioPlayer {
    func executeProgressClosures() {
        for closure in self.progressClosures {
            closure(self.progress)
        }
    }
}
