//
//  AudioBookProgressHelperTest.swift
//  AudiobookerTests
//
//  Created by Valentin Cherepyanko on 01/07/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import XCTest
@testable import Audiobooker

class AudioBookProgressHelperTest: XCTestCase {
    var bookURL: URL!
    var chapterURL: URL!
    var progress: AudioBookProgress!
    var progressHelper: AudiobookProgressHelper!
    
    override func setUp() {
        bookURL = URL(string: "bookurl")!
        chapterURL = URL(string: "chapterurl")!
        
        progress = AudioBookProgress.empty
        progress.selectedChapterIndex = 5
        progress.chapters[chapterURL] = 0.5
        
        progressHelper = AudiobookProgressHelper(storage: DefaultsStorage())
    }

    func testProgressSavingAndFetching() {
        progressHelper.save(progress: progress, for: bookURL)
        
        let savedProgress: AudioBookProgress = progressHelper.getProgress(for: bookURL)!
        
        XCTAssertEqual(savedProgress.selectedChapterIndex, progress.selectedChapterIndex)
        XCTAssertEqual(savedProgress.chapters[chapterURL], progress.chapters[chapterURL])
    }

}
