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
    private var selectedChapterIndex: Int?
    
    public var chapters: [Chapter] = [Chapter]()
    public weak var delegate: IChaptersListControllerDelegate?
    
    
    init(view: ChapterListView,
         interactor: IChapterListInteractor,
         delegate: IChaptersListControllerDelegate) {
        
        self.view = view
        self.interactor = interactor
        self.delegate = delegate
    }
    
    func viewIsReady() {
        self.view.tableView.delegate = self
        self.view.tableView.dataSource = self
        
        self.interactor.output = self
        self.interactor.startLoadingChapters()
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
        self.view.ac.startAnimating()
    }
    func loadingChaptersHasEnded() {
        self.view.ac.stopAnimating()
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
