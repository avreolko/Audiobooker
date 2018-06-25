//
//  ChapterListController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 08/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

final class ChapterListController: NSObject, IController {
    let chapterCellReuseID = "chapterCellReuseID"
    var selectedChapterIndex: Int?
    var interactor: IChaptersListInteractor? {
        didSet {
            interactor?.startLoadingChapters()
        }
    }
    
    public var chapters: [Chapter] = [Chapter]()
    public weak var delegate: IChaptersListControllerDelegate?
    
    private weak var view: ChapterListView!
    
    init(view: ChapterListView) {
        self.view = view
        
        super.init()
        
        self.view.tableView.delegate = self
        self.view.tableView.dataSource = self
    }
    
    func viewIsReady() {
        
    }
    
    deinit {
        self.encode(state: self.state)
    }
}

extension ChapterListController: IChaptersListInteractorOutput {
    func setChapters(chapters: [Chapter]) {
        self.chapters = chapters
        self.view.tableView.reloadData()
        
        self.delegate?.loaded(chapters: self.chapters)
        self.restoreState()
    }
    
    func loadingChaptersHasStarted() {
        self.view.ac?.startAnimating()
    }
    func loadingChaptersHasEnded() {
        self.view.ac?.stopAnimating()
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

extension ChapterListController: IStateable {
    typealias State = ChapterListControllerState
    
    var state: State? {
        guard let index = self.selectedChapterIndex else {
            return nil
        }
        
        return ChapterListControllerState(selectedChapterIndex:index)
    }
    
    var key: String { return "audio player controller state" }
    
    func restore(with state: State) {
        self.selectedChapterIndex = state.selectedChapterIndex
        let indexPath = IndexPath(row: state.selectedChapterIndex, section: 0)
        self.view.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

struct ChapterListControllerState: Codable {
    var selectedChapterIndex: Int
}
