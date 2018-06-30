//
//  IPlayerView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IPlayerViewDelegate: AnyObject {
    func playTapped()
    func nextTapped()
    func previousTapped()
}

protocol IPlayerView: AnyObject {
    var delegate: IPlayerViewDelegate? { get set }
    func set(progress: Float, animated: Bool)
    func set(title: String)
    
    var paused: Bool { get set }
}

extension IPlayerView {
    func set(progress: Float, animated: Bool = true) {
        self.set(progress: progress, animated: animated)
    }
}
