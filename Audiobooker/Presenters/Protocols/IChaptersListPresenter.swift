//
//  IChaptersListPresenter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IChaptersListPresenter {
    weak var viewController: IChaptersListView? { get set }
    var selectedAudioBook: AudioBook? { get set }
}
