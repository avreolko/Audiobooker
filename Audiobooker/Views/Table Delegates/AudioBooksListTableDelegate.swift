//
//  AudioBooksListTableDelegate.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

final class AudioBooksListTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    let audioBookCellReuseID = "audioBookCellReuseID"
    
    weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    
    var audioBooks: [AudioBook] = [AudioBook]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioBooks.count
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
}
