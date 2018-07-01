//
//  AudioBookProgress.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

struct AudioBookProgress: Codable {
    typealias ChapterHash = String
    var chapters: [ChapterHash : Float] = [ChapterHash : Float]()
    var selectedChapterIndex: Int = 0
    
    mutating func set(progress: Float, for chapterHash: ChapterHash) {
        self.chapters[chapterHash] = progress
    }
    
    static let empty = {
       return AudioBookProgress()
    }()
    
    func progress(for chapterHash: ChapterHash) -> Float? {
        return chapters[chapterHash]
    }
}
