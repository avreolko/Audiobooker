//
//  AudiobookDetailsDirector.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 22/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

protocol IDirector {
    associatedtype RootViewController: UIViewController
    init(with rootViewController: RootViewController)
    func assembly()
    func viewIsReady()
}

class AudiobookDetailsDirector: IDirector {
    private unowned var rootVC: RootViewController
    
    var audiobookInfoController: AudiobookInfoController?
    var chapterListController: (ChapterListController & IStateable)?
    var audioPlayerController: (IAudioPlayerController & IStateable)?
    
    var audiobook: AudioBook?
    
    typealias RootViewController = AudiobookDetailsRootController
    
    required init(with rootViewController: RootViewController) {
        self.rootVC = rootViewController
    }
    
    func viewIsReady() {
        self.assembly()
    }
    
    public func assembly() {
        guard let audiobook = self.audiobook else {
            assertionFailure("Audiobook shouldn't be nil at this point")
            return
        }
        
        let audiobookInfoController = AudiobookInfoController(view: self.rootVC.audioBookInfoView)
        audiobookInfoController.audiobook = self.audiobook
        self.audiobookInfoController = audiobookInfoController
        
        let chapterListController = ChapterListController(view: self.rootVC.chapterListView)
        let interactor = ChapterListInteractor(audioBook: audiobook)
        interactor.output = chapterListController
        chapterListController.interactor = interactor
        self.chapterListController = chapterListController
        
        let audioPlayerController = AudioPlayerController(playerView: self.rootVC.playerView)
        audioPlayerController.delegate = self
        self.audioPlayerController = audioPlayerController
        chapterListController.delegate = self
    }
}

extension AudiobookDetailsDirector: IAudioPlayerDelegate {
    func getNextFileURL(for url: URL) -> URL? {
        return self.fileURL(for: url, indexShift: 1)
    }
    
    func getPreviousFileURL(for url: URL) -> URL? {
        return self.fileURL(for: url, indexShift: -1)
    }
    
    private func fileURL(for url: URL, indexShift: Int) -> URL? {
        guard let chapters = self.chapterListController?.chapters else {
            assertionFailure()
            return nil
        }
        
        for (index, chapter) in chapters.enumerated() {
            if (chapter.audioFilePath.absoluteString == url.absoluteString) {
                guard chapters.indices.contains(index + indexShift) else {
                    return nil
                }
                
                return chapters[index + indexShift].audioFilePath
            }
        }
        
        return nil
    }
}

extension AudiobookDetailsDirector: IChaptersListControllerDelegate {
    func select(chapter: Chapter) {
        self.audioPlayerController?.loadFile(url: chapter.audioFilePath)
        self.audioPlayerController?.startPlaying()
    }
    
    func loaded(chapters: [Chapter]) {
        if chapters.count > 0 {
            let chapter = chapters[0]
            self.audioPlayerController?.loadFile(url: chapter.audioFilePath)
        }
    }
}
