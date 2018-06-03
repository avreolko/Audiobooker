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
    func loadChaptersOf(book: AudioBook, completion: ([Chapter]) -> ())
}

class AudioBookDataProvider: IAudioBookDataProvider {
    private let fileManager = FileManager.default
    private let coreDataManager = CoreDataManager()
    
    func loadListOfBooks(completion: ([AudioBook]) -> ()) {
        var audioBooks: [AudioBook] = [AudioBook]()
        
        let fileURLs = self.getContentsOfDirectory(documentsDirectory)
        
        for fileUrl in fileURLs {
            if fileUrl.hasDirectoryPath {
                let audioBook = AudioBook(bookURL: fileUrl)
                audioBooks.append(audioBook)
            }
        }
        
        completion(audioBooks)
    }
    
    func loadChaptersOf(book: AudioBook, completion: ([Chapter]) -> ()) {
        var chapters: [Chapter] = [Chapter]()
        
        let fileURLs = self.getContentsOfDirectory(book.chaptersDirectoryPath)
        for fileUrl in fileURLs {
            if fileUrl.pathExtension == "mp3" {
                let chapter = Chapter(chapterURL: fileUrl)
                chapters.append(chapter)
            }
        }
        
        completion(chapters)
    }
}

private extension AudioBookDataProvider {
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            return fileURLs
        } catch {
            return [URL]()
        }
    }
}
