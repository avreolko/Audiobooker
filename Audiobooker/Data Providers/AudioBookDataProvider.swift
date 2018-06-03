//
//  AudioBookDataProvider.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IAudioBookDataProvider {
    func loadListOfBooks(completion: ([AudioBook]) -> ())
    func loadListOfChapters(bookID: String, completion: ([AudioBook]) -> ())
}

class AudioBookDataProvider: IAudioBookDataProvider {
    private let fileManager = FileManager.default
    private let coreDataManager = CoreDataManager()
    
    func loadListOfBooks(completion: ([AudioBook]) -> ()) {
        do {
            var audioBooks: [AudioBook] = [AudioBook]()
            let fileURLs = try fileManager.contentsOfDirectory(at: self.getDocumentsDirectory(), includingPropertiesForKeys: nil)
            for fileUrl in fileURLs {
                if fileUrl.hasDirectoryPath {
                    let audioBook = AudioBook(bookURL: fileUrl)
                    audioBooks.append(audioBook)
                }
            }
            
            completion(audioBooks)
        } catch {
            print("Error while enumerating files \(self.getDocumentsDirectory().path): \(error.localizedDescription)")
        }
    }
    
    func loadListOfChapters(bookID: String, completion: ([AudioBook]) -> ()) {
        
    }
}

private extension AudioBookDataProvider {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
