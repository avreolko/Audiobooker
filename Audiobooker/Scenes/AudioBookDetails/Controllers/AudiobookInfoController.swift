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
    
    public var audiobook: AudioBook? {
        didSet {
            self.showInfo()
        }
    }
    
    init(view: AudiobookInfoView) {
        self.view = view
    }
    
    func viewIsReady() {
        
    }
}

private extension AudiobookInfoController {
    func showInfo() {
        guard let audiobook = self.audiobook else {
            assertionFailure("audiobook is nil")
            return
        }
        
        self.view.bookTitle.text = audiobook.title
        self.view.author.text = audiobook.author
        
        do {
            let imageDataFromURL = try Data(contentsOf: audiobook.coverPath)
            let image = UIImage(data: imageDataFromURL, scale: UIScreen.main.scale)
            self.view.cover.image = image
        } catch {
            print("Can't find cover of this audiobook. Path: \(audiobook.coverPath.absoluteString)")
        }
    }
}
