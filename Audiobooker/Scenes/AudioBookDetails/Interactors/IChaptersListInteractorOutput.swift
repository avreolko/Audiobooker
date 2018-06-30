//
//  IChaptersListView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

protocol IChaptersListInteractorOutput: IController {
    func setChapters(chapters: [Chapter])
    func loadingChaptersHasStarted()
    func loadingChaptersHasEnded()
}
