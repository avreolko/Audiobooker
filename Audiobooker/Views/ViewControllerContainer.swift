//
//  ViewControllerContainer.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 05/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerContainer: UIView {
    @IBInspectable var autoConstrains: Bool = true
    public var viewController: UIViewController?
    
    public func loadViewController(_ vcid: VCID) {
        if let viewController = vcid.get() {
            self.viewController = viewController
            self.place(viewController)
        }
    }
    
    private func place(_ viewController: UIViewController) {
        self.addSubview(viewController.view)
        
        if self.autoConstrains {
            // add constraints
        }
    }
}

protocol VCID {
    func get() -> UIViewController?
}
