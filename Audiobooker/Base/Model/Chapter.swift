//
//  Chapter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

struct Chapter
{
    var progress: ChapterProgress? = nil
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

    init(progress: ChapterProgress?, otherChapter: Chapter) {

        self.progress = progress
        self.audioFilePath = otherChapter.audioFilePath
        self.title = otherChapter.title
        self.album = otherChapter.album
        self.artist = otherChapter.artist
    }

    mutating func set(progress: ChapterProgress?) {
        self.progress = progress
    }
}

extension Chapter: MD5Hashable
{
    var seed: String {
        return self.title + self.album + self.artist
    }
}
