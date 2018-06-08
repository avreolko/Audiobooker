//
//  ChaptersListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

final class ChapterListInteractor: IChaptersListInteractor {
    let dataProvider: IAudioBookDataProvider = AudioBookDataProvider()
    
    private weak var chapterListController: IChaptersListController?
    
    private let audioBook: AudioBook
    
    init(audioBook: AudioBook) {
        self.audioBook = audioBook
    }
    
    func attach(controller: IController?) {
        if let chapterController = controller as? IChaptersListController {
            self.chapterListController = chapterController
        }
    }
    
    func startLoadingChapters() {
        self.chapterListController?.loadingChaptersHasStarted()
        self.dataProvider.loadChaptersOf(book: audioBook) { (chapters) in
            self.chapterListController?.loadingChaptersHasEnded()
            self.chapterListController?.setChapters(chapters: chapters)
        }
    }
}
