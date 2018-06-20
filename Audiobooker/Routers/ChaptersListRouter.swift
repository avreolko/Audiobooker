//
//  ChaptersListViewController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class ChaptersListRouter: DataViewController {
    var chapterListController: IChaptersListInteractorOutput?
    var audioPlayerController: IAudioPlayerController?
    
    var audioBook: AudioBook?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var panel: UIView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var ac: UIActivityIndicatorView!
    @IBOutlet weak var playerView: PlayerView!
    
    override func passData(_ object: Any?) {
        if let audioBook = object as? AudioBook {
            self.audioBook = audioBook
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
        self.assembly()
    }
    
    func assembly() {
        guard let audiobook = self.audioBook else {
            assertionFailure("Audiobook is nil")
            return
        }
        
        let chapterListController = ChapterListController(table: self.tableView, ac: self.ac)
        let interactor = ChapterListInteractor(audioBook: audiobook)
        interactor.output = chapterListController
        chapterListController.interactor = interactor
        
        
        self.chapterListController = chapterListController
        
        let audioPlayerController = AudioPlayerController(playerView: self.playerView)
        audioPlayerController.delegate = chapterListController
        self.audioPlayerController = audioPlayerController
        chapterListController.delegate = audioPlayerController
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension ChaptersListRouter {
    func setupView() {
        UIViewDecorator.decorate(view: self.panel, config: UIViewDecoratorConfig.bigPanel)
        UIViewDecorator.decorate(view: self.cover, config: UIViewDecoratorConfig.audioBookCover)
        
        guard let audioBook = self.audioBook else { return }
        
        self.bookTitle.text = audioBook.title
        self.author.text = audioBook.author
        
        do {
            let imageDataFromURL = try Data(contentsOf: audioBook.coverPath)
            let image = UIImage(data: imageDataFromURL, scale: UIScreen.main.scale)
            self.cover.image = image
        } catch {
            print("Can't find cover of this audiobook. Path: \(audioBook.coverPath.absoluteString)")
        }
    }
}
