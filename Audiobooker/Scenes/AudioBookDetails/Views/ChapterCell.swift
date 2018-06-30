//
//  ChapterCell.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class ChapterCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var progress: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        } else {
            self.backgroundColor = UIColor.clear
        }
    }
}
