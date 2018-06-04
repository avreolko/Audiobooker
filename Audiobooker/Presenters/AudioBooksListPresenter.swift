//
//  AudioBooksListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

class AudioBooksListPresenter: IAudioBooksListPresenter {
    let dataProvider: IAudioBookDataProvider = AudioBookDataProvider()
    weak var viewController: IAudioBooksListView?
    
    func viewIsReady() {
        dataProvider.loadListOfBooks { (books) in
            self.viewController?.setBooks(books)
        }
    }
}
