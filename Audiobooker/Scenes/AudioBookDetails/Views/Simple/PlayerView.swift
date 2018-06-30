//
//  PlayerView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
import AVFoundation

enum PlayerViewState {
    case paused
    case playing
    
    func buttonImageName() -> String {
        switch self {
            case .paused: return "play"
            case .playing: return "pause"
        }
    }
}

class PlayerView: UIView, IPlayerView {
    weak var delegate: IPlayerViewDelegate?
    
    @IBOutlet var progressBar: ProgressBar!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    func set(progress: Float, animated: Bool = true) {
        self.progressBar.set(progress: progress, animated: animated)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        delegate?.playTapped()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        delegate?.nextTapped()
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        delegate?.previousTapped()
    }
    
    func set(title: String) {
        self.titleLabel.text = title
    }
    
    var paused: Bool = true {
        didSet {
            let state: PlayerViewState = paused ? .paused : .playing
            self.playButton.setImage(UIImage(named: state.buttonImageName()), for: .normal)
        }
    }
}
