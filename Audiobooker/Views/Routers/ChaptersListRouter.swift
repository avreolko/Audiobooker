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
    var chapterListInteractor: IChaptersListInteractor?
    var chapterListController: IChaptersListController?
    
    var audioBook: AudioBook?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var panel: UIView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var ac: UIActivityIndicatorView!
    
    override func passData(_ object: Any?) {
        if let audioBook = object as? AudioBook {
            self.audioBook = audioBook
            self.chapterListInteractor = ChapterListInteractor(audioBook: audioBook)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chapterListController = ChapterListController(table: self.tableView, ac: self.ac)
        chapterListController.output = self
        self.chapterListController = chapterListController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.chapterListInteractor?.attach(controller: chapterListController)
        self.chapterListInteractor?.startLoadingChapters()
        self.setupView()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ChaptersListRouter: IChaptersListControllerOutput {
    func select(chapter: Chapter) {
        print("chapter selected")
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
