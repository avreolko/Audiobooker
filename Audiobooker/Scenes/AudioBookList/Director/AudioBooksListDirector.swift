//
//  AudioBooksListDirector.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudioBooksListDirector: IDirector {
    typealias RootViewController = AudioBookListRootController
    
    private unowned var rootVC: RootViewController
    
    private var audioBooksListController: AudioBookListController?
    
    public init(rootViewController: RootViewController) {
        self.rootVC = rootViewController
    }
    
    public func viewIsReady() {
        self.assembly()
        self.audioBooksListController?.viewIsReady()
    }
    
    public func assembly() {
        let dataProvider = AudioBookDataProvider()
        let interactor = AudioBooksListInteractor(dataProvider: dataProvider)
        let controller = AudioBookListController(view: self.rootVC.audioBooksListView,
                                                 interactor: interactor,
                                                 delegate: self)
        
        self.audioBooksListController = controller
    }
}

extension AudioBooksListDirector: AudioBookListControllerDelegate {
    func select(book: AudioBook) {
        self.rootVC.segue(VCSegue.selectAudioBook.rawValue, object: book)
    }
}
