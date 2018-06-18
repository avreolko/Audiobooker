//
//  ChapterListController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 08/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

final class ChapterListController: NSObject {
    let chapterCellReuseID = "chapterCellReuseID"
    var interactor: IChaptersListInteractor? {
        didSet {
            interactor?.startLoadingChapters()
        }
    }
    
    private var chapters: [Chapter] = [Chapter]()
    
    private weak var ac: UIActivityIndicatorView?
    private weak var tableView: UITableView?
    public weak var output: IChaptersListControllerOutput?
    
    init(table: UITableView,
         ac: UIActivityIndicatorView? = nil) {
        
        self.tableView = table
        self.ac = ac
        
        super.init()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
}

extension ChapterListController: IChaptersListInteractorOutput {
    func setChapters(chapters: [Chapter]) {
        self.chapters = chapters
        tableView?.reloadData()
    }
    
    func loadingChaptersHasStarted() {
        ac?.startAnimating()
    }
    func loadingChaptersHasEnded() {
        ac?.stopAnimating()
    }
}

extension ChapterListController: UITableViewDelegate, UITableViewDataSource {
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
            chapterCell.title.text = chapter.title
            chapterCell.progress.text = "\(chapter.progress)"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapter = self.chapters[indexPath.row]
        self.output?.select(chapter: chapter)
    }
}
