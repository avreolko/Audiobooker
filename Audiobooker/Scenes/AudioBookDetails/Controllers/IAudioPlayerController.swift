//
//  IAudioPlayer.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit


protocol IAudioPlayerDelegate: AnyObject {
    func getNextFileURL(for url: URL) -> URL?
    func getPreviousFileURL(for url: URL) -> URL?
}

protocol IAudioPlayerController {
    init(playerView: IPlayerView)
    var progress: Float { get }
    var delegate: IAudioPlayerDelegate? { get set }
    func playFile(url: URL)
}
