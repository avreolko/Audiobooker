//
//  AudioBooksListInteractor.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

class AudioBooksListInteractor: IAudioBooksListInteractor {
    let dataProvider: IAudioBookDataProvider = AudioBookDataProvider()
    weak var output: IAudioBooksListView?
    
    func startLoadingBooks() {
        dataProvider.loadListOfBooks { (books) in
            self.output?.setBooks(books)
        }
    }
}
