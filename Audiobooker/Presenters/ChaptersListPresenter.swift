//
//  ChaptersListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

class ChaptersListPresenter: IChaptersListPresenter {
    let dataProvider: IAudioBookDataProvider = AudioBookDataProvider()
    weak var viewController: IChaptersListView?
    var selectedAudioBook: AudioBook? {
        didSet { self.loadChapters() }
    }
    
    private func loadChapters() {
        guard let audioBook = self.selectedAudioBook else { return }
        self.dataProvider.loadChaptersOf(book: audioBook) { (chapters) in
            viewController?.setChapters(chapters: chapters)
        }
    }
}
