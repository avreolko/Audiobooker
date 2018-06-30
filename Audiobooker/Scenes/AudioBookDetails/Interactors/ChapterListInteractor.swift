//
//  ChaptersListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

final class ChapterListInteractor: IChapterListInteractor {
    let dataProvider: IAudioBookDataProvider = AudioBookDataProvider()
    
    public weak var output: IChaptersListInteractorOutput?
    
    private let audioBook: AudioBook
    
    init(audioBook: AudioBook) {
        self.audioBook = audioBook
    }
    
    func startLoadingChapters() {
        self.output?.loadingChaptersHasStarted()
        self.dataProvider.loadChaptersOf(book: audioBook) { (chapters) in
            self.output?.loadingChaptersHasEnded()
            self.output?.setChapters(chapters: chapters)
        }
    }
}
