//
//  AudiobookInfoController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 22/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class AudiobookInfoController: NSObject, IController {
    private weak var view: AudiobookInfoView!
    
    private let audiobook: AudioBook
    
    init(view: AudiobookInfoView,
         audiobook: AudioBook) {
        
        self.view = view
        self.audiobook = audiobook
    }
    
    func viewIsReady() {
        self.showInfo()
    }
}

private extension AudiobookInfoController {
    func showInfo() {
        self.view.bookTitle.text = self.audiobook.title
        self.view.author.text = self.audiobook.author
        
        do {
            let imageDataFromURL = try Data(contentsOf: self.audiobook.coverPath)
            let image = UIImage(data: imageDataFromURL, scale: UIScreen.main.scale)
            self.view.cover.image = image
        } catch {
            print("Can't find cover of this audiobook. Path: \(self.audiobook.coverPath.absoluteString)")
        }
    }
}
