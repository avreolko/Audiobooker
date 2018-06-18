//
//  ProgressBar.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 18/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    @IBOutlet private var line: UIView!
    @IBOutlet private var lineWidth: NSLayoutConstraint!
    
    lazy var width: CGFloat = {
        return self.bounds.width
    }()
    
    func set(progress: Float, animated: Bool = true) {
        let lineWidth = self.width * CGFloat(progress)
        
        self.lineWidth.constant = lineWidth
        if animated {
            UIView.animate(withDuration: 0.4, animations: {
                self.layoutIfNeeded()
            })
        }
    }
}
