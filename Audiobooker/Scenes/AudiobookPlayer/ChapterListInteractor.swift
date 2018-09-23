//
//  ChaptersListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IChapterListInteractor
{
    func loadChapters(_ completion: @escaping ([Chapter]) -> () )
}

final class ChapterListInteractor: IChapterListInteractor
{
    let dataProvider: IAudioBookDataProvider = AudioBookDataProvider()
    
    private let audioBook: AudioBook
    private let audiobookProgressHelper: AudiobookProgressHelper
    
    init(audioBook: AudioBook, audiobookProgressHelper: AudiobookProgressHelper) {
        self.audioBook = audioBook
        self.audiobookProgressHelper = audiobookProgressHelper
    }
    
    func loadChapters(_ completion: @escaping ([Chapter]) -> () ) {
        self.dataProvider.loadChaptersOf(book: audioBook) { (chapters) in
            let chaptersWithProgress = self.loadProgress(for: chapters)
            completion(chaptersWithProgress)
        }
    }

    func loadProgress(for chapters: [Chapter]) -> [Chapter] {
        guard let audibookProgress = audiobookProgressHelper.getProgress(for: audioBook.md5Hash) else {
            print("[ChapterListInteractor] для этой книги отсутствует прогресс, продолжаю без него")
            return chapters
        }

        return chapters.map { (chapter) -> Chapter in
            let chapterProgress = audibookProgress.chaptersProgresses[chapter.md5Hash]
            return Chapter(progress: chapterProgress, otherChapter: chapter)
        }
    }
}
