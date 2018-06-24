//
//  AudiobookInfoView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 24/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class AudiobookInfoView: UIView {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        self.decorate()
    }
}

private extension AudiobookInfoView {
    func decorate() {
        UIViewDecorator.decorate(view: self.cover, config: .audioBookCover)
    }
}
