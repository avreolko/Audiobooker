//
//  AudioBook.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

struct AudioBook {
    let title: String
    let author: String
    let chaptersDirectoryPath: URL
    let coverPath: URL
    let id: String
    
    init(bookURL: URL) {
        self.title = bookURL.lastPathComponent
        self.author = ""
        self.chaptersDirectoryPath = bookURL
        self.coverPath = bookURL.appendingPathComponent("cover")
        self.id = "kkkk"
    }
}
