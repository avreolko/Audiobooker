//
//  IChaptersListControllerDelegate.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

protocol IChaptersListControllerDelegate: AnyObject {
    func select(chapter: Chapter)
}
