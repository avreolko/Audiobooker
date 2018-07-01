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
    
    public func save(progress: AudioBookProgress, for bookHash: String) {
        storage.save(progress, for: bookHash)
    }
    
    public func getProgress(for bookHash: String) -> AudioBookProgress? {
        let savedProgress: AudioBookProgress? = storage.fetch(for: bookHash)
        return savedProgress
    }
}
