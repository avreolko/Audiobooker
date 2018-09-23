//
//  UIViewControllerExtensions.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

public enum VCSegue: String {
    case selectAudioBook = "selectAudioBook"
}

class DataViewController: UIViewController {
    var segueObjects : NSMutableDictionary = NSMutableDictionary()

    var data: Any?

    // segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toViewController = segue.destination as? DataViewController,
            let segueID = segue.identifier {

            toViewController.data = segueObjects.object(forKey: segueID)
            segueObjects.removeObject(forKey: segueID)
        }
    }
    
    func segue(_ segue: String) {
        self.segue(segue, object: nil)
    }
    
    func segue(_ segue: String, object: Any?) {
        if let data = object {
            segueObjects.setObject(data, forKey: segue as NSCopying)
        }
        
        self.performSegue(withIdentifier: segue, sender: self)
    }
}
