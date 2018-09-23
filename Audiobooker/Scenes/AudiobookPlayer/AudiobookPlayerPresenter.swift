//
//  AudiobookPlayerPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 21/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

protocol IPresenter
{
    func viewIsReady()
}

class AudiobookPlayerPresenter: IPresenter
{
    private let audiobookInfo: AudioBook
    private let ui: IAudiobookPlayerUI
    private let interactor: ChapterListInteractor

    init(audiobook: AudioBook,
         ui: IAudiobookPlayerUI,
         interactor: ChapterListInteractor) {

        self.audiobookInfo = audiobook
        self.ui = ui
        self.interactor = interactor
    }

    func viewIsReady() {
        ui.show(audiobookInfo)
        loadChapters()
    }
}


private extension AudiobookPlayerPresenter
{
    func loadChapters() {
        interactor.loadChapters { [weak self] chapters in
            self?.ui.show(chapters)
        }
    }
}
