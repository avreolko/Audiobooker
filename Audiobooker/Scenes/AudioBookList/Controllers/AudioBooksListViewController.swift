//
//  ViewController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudioBooksListViewController: DataViewController {
    var interactor: IAudioBooksListInteractor = AudioBooksListInteractor()
    let audioBookCellReuseID = "audioBookCellReuseID"
    var audioBooks: [AudioBook] = [AudioBook]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.interactor.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deselectRows()
        self.interactor.startLoadingBooks()
    }
    
    func deselectRows() {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}

extension AudioBooksListViewController: IAudioBooksListView {
    func setBooks(_ books: [AudioBook]) {
        self.audioBooks = books
        tableView?.reloadData()
    }
}

extension AudioBooksListViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioBook = self.audioBooks[indexPath.row]
        self.segue(VCSegue.selectAudioBook.rawValue, object: audioBook)
    }
}