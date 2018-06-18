//
//  AudioPlayerController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudioPlayerController: IAudioPlayerController {
    private weak var playerView: IPlayerView?
    weak var delegate: IAudioPlayerDelegate?
    
    required init(playerView: IPlayerView) {
        self.playerView = playerView
        self.playerView?.delegate = self
    }
    
    var progress: Float {
        return 0
    }
    
    func playFile(url: URL) {
        
    }
}

extension AudioPlayerController: IPlayerViewDelegate {
    func playTapped() {
        
    }
    
    func nextTapped() {
        
    }
    
    func previousTapped() {
        
    }
}
