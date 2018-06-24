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
    func viewIsReady()
    func assembly()
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
    
    func assembly() {
        guard let audiobook = self.audiobook else {
            assertionFailure("Audiobook shouldn't be nil at this point")
            return
        }
        
        let chapterListController = ChapterListController(view: self.rootVC.chapterListView)
        let interactor = ChapterListInteractor(audioBook: audiobook)
        interactor.output = chapterListController
        chapterListController.interactor = interactor
        self.chapterListController = chapterListController
        
        let audioPlayerController = AudioPlayerController(playerView: self.rootVC.playerView)
        audioPlayerController.delegate = chapterListController
        self.audioPlayerController = audioPlayerController
        chapterListController.delegate = audioPlayerController
        
        let audiobookInfoController = AudiobookInfoController(view: self.rootVC.audioBookInfoView)
        audiobookInfoController.audiobook = self.audiobook
        self.audiobookInfoController = audiobookInfoController
    }
}
