//
//  AudiobookProgressHelper.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 25/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

class AudiobookProgressHelper {
    private let storage: IStorage
    
    init(storage: IStorage) {
        self.storage = storage
    }
    
    func save(progress: AudioBookProgress, for url: URL) {
        storage.save(progress, for: url.absoluteString)
    }
    
    func getProgress(for url: URL) -> AudioBookProgress? {
        return storage.fetch(for: url.absoluteString)
    }
}

struct AudioBookProgress: Codable {
    var chapters: [URL : Float] = [URL : Float]()
    
    mutating func set(progress: Float, for chapterURL: URL) {
        self.chapters[chapterURL] = progress
    }
}
