//
//  ChapterListController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 08/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

final class ChapterListController: NSObject, IController {
    private weak var view: ChapterListView!
    
    private let chapterCellReuseID = "chapterCellReuseID"
    private var interactor: IChapterListInteractor
    private(set) var selectedChapterIndex: Int?
    
    public var chapters: [Chapter] = [Chapter]()
    public weak var delegate: IChaptersListControllerDelegate?
    
    init(view: ChapterListView,
         interactor: IChapterListInteractor,
         delegate: IChaptersListControllerDelegate) {
        
        self.view = view
        self.interactor = interactor
        self.delegate = delegate
    }
    
    public func viewIsReady() {
        self.view.tableView.delegate = self
        self.view.tableView.dataSource = self
        
        self.loadData()
    }
    
    public func select(chapterIndex: Int) {
        guard chapterIndex < (self.chapters.count - 1) else {
            assertionFailure()
            return
        }
        
        self.selectedChapterIndex = chapterIndex
        self.view.tableView.scrollToRow(at: IndexPath(row: chapterIndex, section: 0), at: .top, animated: true)
    }
}

private extension ChapterListController {
    func loadData() {
        self.view.ac.startAnimating()
        
        self.interactor.loadChapters { (chapters) in
            self.view.ac.stopAnimating()
            
            self.chapters = chapters
            self.view.tableView.reloadData()
            self.delegate?.loaded(chapters: self.chapters)
        }
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
        self.selectedChapterIndex = indexPath.row
        
        let chapter = self.chapters[indexPath.row]
        self.delegate?.select(chapter: chapter)
        self.view.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
