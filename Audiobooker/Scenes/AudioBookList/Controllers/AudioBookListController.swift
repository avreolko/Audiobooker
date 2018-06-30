//
//  AudioBookListController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

protocol AudioBookListControllerDelegate: AnyObject {
    func select(book: AudioBook)
}

class AudioBookListController: NSObject {
    let audioBookCellReuseID = "audioBookCellReuseID"
    
    private let view: AudioBookListView
    private let interactor: AudioBooksListInteractor
    private weak var delegate: AudioBookListControllerDelegate?
    
    private var audioBooks: [AudioBook] = [AudioBook]()
    
    init(view: AudioBookListView,
         interactor: AudioBooksListInteractor,
         delegate: AudioBookListControllerDelegate) {
        
        self.view = view
        self.interactor = interactor
        self.delegate = delegate
    }
}

extension AudioBookListController: IController {
    func viewIsReady() {
        self.view.tableView.delegate = self
        self.view.tableView.dataSource = self
        
        self.interactor.loadBooks { [weak self] (books) in
            self?.showList(with: books)
        }
    }
}

private extension AudioBookListController {
    func showList(with books: [AudioBook]) {
        self.audioBooks = books
        
        self.view.tableView.reloadData()
    }
}

extension AudioBookListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audioBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: audioBookCellReuseID, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let audioBookCell = cell as? AudioBookCell {
            let audioBook = self.audioBooks[indexPath.row]
            audioBookCell.setTitle(audioBook.title)
            audioBookCell.setAuthor(audioBook.author)
            audioBookCell.setCoverPath(audioBook.coverPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioBook = self.audioBooks[indexPath.row]
        self.delegate?.select(book: audioBook)
    }
}
