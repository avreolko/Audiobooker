//
//  ViewController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudioBooksListViewController: UIViewController, IAudioBooksListView {
    var presenter: IAudioBooksListPresenter = AudioBooksListPresenter()
    let tableDelegate: AudioBooksListTableDelegate = AudioBooksListTableDelegate()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewIsReady()
        self.tableDelegate.tableView = self.tableView
    }
    
    func setBooks(_ books: [AudioBook]) {
        self.tableDelegate.audioBooks = books
    }
}
