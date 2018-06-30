//
//  Chapter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

struct Chapter {
    let progress: Double = 0 // 0-1
    let audioFilePath: URL
    let title: String
    let album: String
    let artist: String
    
    init(chapterURL: URL) {
        self.audioFilePath = chapterURL
        
        let mp3TagContainer = MP3TagContainer(pathToMP3File: audioFilePath)
        self.title = mp3TagContainer.title
        self.album = mp3TagContainer.album
        self.artist = mp3TagContainer.artist
    }
}
