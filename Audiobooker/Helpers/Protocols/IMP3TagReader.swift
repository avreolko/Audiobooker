//
//  IMP3TagReader.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 04/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IMP3TagContainer {
    init(pathToMP3File: URL)
    
    var title: String { get }
    var album: String { get }
    var artist: String { get }
    var albumArtist: String { get }
}
