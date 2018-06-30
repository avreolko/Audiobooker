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
    
    public func save(progress: AudioBookProgress, for url: URL) {
        storage.save(progress, for: url.absoluteString)
    }
    
    public func getProgress(for url: URL) -> AudioBookProgress {
        guard let savedProgress: AudioBookProgress = storage.fetch(for: url.absoluteString) else {
            return AudioBookProgress.empty
        }
        
        return savedProgress
    }
}
