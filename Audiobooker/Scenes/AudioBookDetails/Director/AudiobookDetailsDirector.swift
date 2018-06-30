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
}

class AudiobookDetailsDirector: IDirector {
    typealias RootViewController = AudiobookDetailsRootController
    
    private var progressHelper: AudiobookProgressHelper
    
    private unowned var rootVC: RootViewController
    
    var audiobookInfoController: AudiobookInfoController?
    var chapterListController: ChapterListController?
    var audioPlayerController: AudioPlayerController?
    
    var audiobook: AudioBook
    
    public init(rootViewController: RootViewController,
                            audiobook: AudioBook,
                            progressHelper: AudiobookProgressHelper) {
        
        self.rootVC = rootViewController
        self.audiobook = audiobook
        self.progressHelper = progressHelper
    }
    
    func viewIsReady() {
        self.assembly()
        self.audioPlayerController?.viewIsReady()
        self.chapterListController?.viewIsReady()
        self.audiobookInfoController?.viewIsReady()
    }
    
    public func assembly() {
        self.audiobookInfoController = AudiobookInfoController(view: self.rootVC.audioBookInfoView,
                                                              audiobook: self.audiobook)
        
        let interactor = ChapterListInteractor(audioBook: self.audiobook)
        self.chapterListController = ChapterListController(view: self.rootVC.chapterListView,
                                                           interactor: interactor,
                                                           delegate: self)
        
        self.audioPlayerController = AudioPlayerController(playerView: self.rootVC.playerView,
                                                          delegate: self,
                                                          audioPlayer: AVPlayer())
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

//extension AudiobookDetailsDirector: IStateable {
//    var state: Codable? {
//        guard let audioState = self.audioPlayerController?.state as? AudioPlayerControllerState,
//            let listState = self.chapterListController?.state as? ChapterListControllerState else {
//            return nil
//        }
//
//        return AudiobookDetailsDirectorState(audioplayerControllerState: audioState,
//                                             chapterListControllerState: listState)
//    }
//
//    var key: String {
//        return "AudiobookDetailsDirector"
//    }
//
//    func restore() {
//        guard let state: AudiobookDetailsDirectorState = self.decodeState() else {
//            return
//        }
//
//        self.restore(with: state)
//    }
//
//    func restore(with state: Codable?) {
//        guard let state = state as? AudiobookDetailsDirectorState else {
//            return
//        }
//
//        self.audioPlayerController?.restore(with: state.audioplayerControllerState)
//        self.chapterListController?.restore(with: state.chapterListControllerState)
//    }
//}
//
//struct AudiobookDetailsDirectorState: Codable {
//    var audioplayerControllerState: AudioPlayerControllerState
//    var chapterListControllerState: ChapterListControllerState
//}
