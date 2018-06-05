//
//  VC.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 05/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

enum VC: String, VCID {
    case audioPlayer = "AudioPlayerController"
    
    func get() -> UIViewController? {
        guard let vcArray = Bundle.main.loadNibNamed(self.rawValue, owner: nil, options: nil) else {
            return nil
        }
        
        if let vc = vcArray[0] as? UIViewController {
            return vc
        } else {
            return nil
        }
    }
}
