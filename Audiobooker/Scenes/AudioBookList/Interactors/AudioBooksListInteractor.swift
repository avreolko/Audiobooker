//
//  AudioBooksListInteractor.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

class AudioBooksListInteractor: IAudioBooksListInteractor {
    let dataProvider: IAudioBookDataProvider
    
    init(dataProvider: IAudioBookDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func loadBooks(completion: @escaping ([AudioBook]) -> ()) {
        self.dataProvider.loadListOfBooks { (books) in
            completion(books)
        }
    }
}
