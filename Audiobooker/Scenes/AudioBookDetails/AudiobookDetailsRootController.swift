//
//  ChaptersListViewController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class AudiobookDetailsRootController: DataViewController {
    private var director: AudiobookDetailsDirector?
    
    @IBOutlet var panel: UIView!
    
    @IBOutlet weak var audioBookInfoView: AudiobookInfoView!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var chapterListView: ChapterListView!
    
    override func passData(_ object: Any?) {
        if let audiobook = object as? AudioBook {
            let progressHelper = AudiobookProgressHelper(storage: DefaultsStorage())
            
            self.director = AudiobookDetailsDirector(rootViewController: self,
                                                     audiobook: audiobook,
                                                     progressHelper: progressHelper)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.decorate()
        
        self.director?.viewIsReady()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension AudiobookDetailsRootController {
    func decorate() {
        UIViewDecorator.decorate(view: self.panel, config: .darkBlur)
    }
}
