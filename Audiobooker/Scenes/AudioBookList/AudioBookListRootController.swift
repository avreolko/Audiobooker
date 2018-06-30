//
//  ViewController.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudioBookListRootController: DataViewController {
    @IBOutlet weak var audioBooksListView: AudioBookListView!
    
    private var director: AudioBooksListDirector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.director = AudioBooksListDirector(rootViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deselectRows()
        
        self.director?.viewIsReady()
    }
}

private extension AudioBookListRootController {
    func deselectRows() {
        let tableView = self.audioBooksListView.tableView
        
        if let index = tableView?.indexPathForSelectedRow {
            tableView?.deselectRow(at: index, animated: true)
        }
    }
}
