//
//  AudiobookDetailsDirector.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 22/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol IDirector {
    associatedtype RootViewController: UIViewController
    func assembly()
    func viewIsReady()
    func viewWillClose()
}

class AudiobookDetailsDirector: NSObject, IDirector {
    typealias RootViewController = AudiobookDetailsRootController
    
    private var progressHelper: AudiobookProgressHelper
    
    private unowned var rootVC: RootViewController
    
    private var audiobookInfoController: AudiobookInfoController?
    private var chapterListController: ChapterListController?
    private var audioPlayerController: AudioPlayerController?
    
    private var audiobook: AudioBook
    
    public init(rootViewController: RootViewController,
                            audiobook: AudioBook,
                            progressHelper: AudiobookProgressHelper) {
        
        self.rootVC = rootViewController
        self.audiobook = audiobook
        self.progressHelper = progressHelper
    }
    
    public func viewIsReady() {
        self.assembly()
        self.audioPlayerController?.viewIsReady()
        self.chapterListController?.viewIsReady()
        self.audiobookInfoController?.viewIsReady()
    }
    
    public func viewWillClose() {
        self.audioPlayerController?.stopPlaying()
        self.saveProgress()
    }
    
    func assembly() {
        self.audiobookInfoController = AudiobookInfoController(view: self.rootVC.audioBookInfoView,
                                                              audiobook: self.audiobook)
        
        let interactor = ChapterListInteractor(audioBook: self.audiobook)
        self.chapterListController = ChapterListController(view: self.rootVC.chapterListView,
                                                           interactor: interactor,
                                                           delegate: self)
        
        self.audioPlayerController = AudioPlayerController(playerView: self.rootVC.playerView,
                                                          delegate: self,
                                                          audioPlayer: AudioPlayer.shared)
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
        try? self.restoreProgress(with: chapters)
    }
}

extension AudiobookDetailsDirector: IAppStateListener {
    func appBecomeActive() { }
    func appBecomeUnknown() { }
    
    func appBecomeNonActive() {
        self.saveProgress()
    }
}

private extension AudiobookDetailsDirector {
    func saveProgress() {
        guard let selectedChapterIndex = self.chapterListController?.selectedChapterIndex else {
            assertionFailure("Что-то пошло не так с сохранением прогресса")
            return
        }
        
        guard let chapterURL = self.audioPlayerController?.fileURL else {
            assertionFailure("Что-то пошло не так с сохранением прогресса")
            return
        }
        
        guard let chapterProgress = self.audioPlayerController?.progress else {
            assertionFailure("Что-то пошло не так с сохранением прогресса")
            return
        }
        
        let audioBookURL = self.audiobook.chaptersDirectoryPath
        
        var audioBookProgress = self.progressHelper.getProgress(for: audioBookURL) ?? AudioBookProgress.empty
        
        audioBookProgress.set(progress: chapterProgress, for: chapterURL)
        audioBookProgress.selectedChapterIndex = selectedChapterIndex
        
        self.progressHelper.save(progress: audioBookProgress, for: audioBookURL)
    }
    
    func restoreProgress(with chapters: [Chapter]) throws {
        let audioBookURL = self.audiobook.chaptersDirectoryPath
        guard let progress = self.progressHelper.getProgress(for: audioBookURL) else {
            throw NSError(domain: "There is no progress for this audio book.", code: 4, userInfo: nil)
        }
        
        let index = progress.selectedChapterIndex
        self.chapterListController?.select(chapterIndex: index)
        
        let chapter = chapters[index]
        self.audioPlayerController?.loadFile(url: chapter.audioFilePath)
        
        if let chapterProgress = progress.progress(for: chapter.audioFilePath) {
            self.audioPlayerController?.progress = chapterProgress
        }
    }
}
