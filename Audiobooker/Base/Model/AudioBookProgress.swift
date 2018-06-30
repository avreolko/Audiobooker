//
//  AudioBookProgress.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

struct AudioBookProgress: Codable {
    var chapters: [URL : Float] = [URL : Float]()
    var selectedChapterIndex: Int = 0
    
    mutating func set(progress: Float, for chapterURL: URL) {
        self.chapters[chapterURL] = progress
    }
    
    static let empty = {
       return AudioBookProgress()
    }()
}
