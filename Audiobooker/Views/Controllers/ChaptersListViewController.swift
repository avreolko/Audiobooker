//
//  ChaptersListViewController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class ChaptersListViewController: DataViewController, IChaptersListView {
    let chapterCellReuseID = "chapterCellReuseID"
    var presenter: IChaptersListPresenter = ChaptersListPresenter()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var panel: UIView!
    private var audioBook: AudioBook?
    private var chapters: [Chapter] = [Chapter]()
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func passData(_ object: Any?) {
        if let audioBook = object as? AudioBook {
            self.audioBook = audioBook
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.setupView()
        UIViewDecorator.decorate(view: self.panel, config: UIViewDecoratorConfig.bigPanel)
        UIViewDecorator.decorate(view: self.cover, config: UIViewDecoratorConfig.audioBookCover)
        
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewController = self
        self.presenter.selectedAudioBook = audioBook
    }
    
    func setChapters(chapters: [Chapter]) {
        self.chapters = chapters
        self.tableView.reloadData()
    }
}

extension ChaptersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chapterCellReuseID, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let chapterCell = cell as? ChapterCell {
            let chapter = self.chapters[indexPath.row]
            chapterCell.title.text = chapter.name
            chapterCell.progress.text = "\(chapter.progress)"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

private extension ChaptersListViewController {
    func setupView() {
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
