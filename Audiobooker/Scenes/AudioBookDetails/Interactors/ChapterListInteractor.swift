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
    
    private let audioBook: AudioBook
    
    init(audioBook: AudioBook) {
        self.audioBook = audioBook
    }
    
    func loadChapters(_ completion: @escaping ([Chapter]) -> () ) {
        self.dataProvider.loadChaptersOf(book: audioBook) { (chapters) in
            completion(chapters)
        }
    }
}
