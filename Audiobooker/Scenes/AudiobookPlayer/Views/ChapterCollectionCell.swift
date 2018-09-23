//
//  ChapterCollectionCell.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 23/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class ChapterCollectionCell: UICollectionViewCell
{
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var progressView: CircularProgressView!

    func set(progress: Float) {
        progressView.progress = progress
    }

    func set(index: Int) {
        indexLabel.text = "\(index)"
    }
}
