//
//  AudioplayerView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 21/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

typealias VoidHandler = () -> ()

enum AudioplayerViewState
{
    case playing
    case paused
}

class AudioplayerView: UIView
{
    public var rollBackHandler: VoidHandler?
    public var rollForwardHandler: VoidHandler?
    public var playHandler: VoidHandler?

    @IBOutlet weak var playButton: UIButton!

    public var state: AudioplayerViewState = .paused {
        didSet {
            playButton.isHighlighted = (state == .paused)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        UIViewDecorator.decorate(view: self, config: .player)
    }

    @IBAction func rollBackTapped(_ sender: Any) {
        rollBackHandler?()
    }

    @IBAction func rollForwardTapped(_ sender: Any) {
        rollForwardHandler?()
    }

    @IBAction func playTapped(_ sender: Any) {
        playHandler?()
    }
}
