//
//  IChaptersListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IChapterListInteractor {
    func loadChapters(_ completion: @escaping ([Chapter]) -> () )
}
