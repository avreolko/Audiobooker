//
//  AudioBookProgress.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

struct AudioBookProgress: Codable
{
    typealias ChapterHash = String
    var chaptersProgresses: [ChapterHash : ChapterProgress] = [ChapterHash : ChapterProgress]()
    var selectedChapterIndex: Int = 0
    
    static let empty = {
       return AudioBookProgress()
    }()
}

struct ChapterProgress: Codable
{
    let progress: Float
    let done: Bool
}
