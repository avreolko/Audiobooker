//
//  Chapter.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

struct Chapter {
    let audioBookID: String
    let name: String
    let progress: Double // 0-1
    let audioFilePath: URL
}
