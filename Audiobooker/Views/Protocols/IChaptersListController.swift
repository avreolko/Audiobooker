//
//  IChaptersListView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

protocol IChaptersListController: IController {
    init(table: UITableView, ac: UIActivityIndicatorView?)
    func setChapters(chapters: [Chapter])
    func loadingChaptersHasStarted()
    func loadingChaptersHasEnded()
}

protocol IChaptersListControllerOutput: AnyObject {
    func select(chapter: Chapter)
}
