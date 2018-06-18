//
//  PlayerView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView, IPlayerView {
    weak var delegate: IPlayerViewDelegate?
    
    @IBOutlet var progressBar: ProgressBar!
    @IBOutlet var playButton: UIButton!
    
    func set(progress: Float) {
        self.progressBar.set(progress: progress)
    }
}
