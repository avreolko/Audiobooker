//
//  UIViewDecorator.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

class UIViewDecorator {
    static func decorate(view: UIView, config: UIViewDecoratorConfig = UIViewDecoratorConfig.basic) {
        view.backgroundColor = config.backgroundColor
        view.layer.shadowColor = config.shadowColor
        view.layer.shadowRadius = config.shadowRadius
        view.layer.shadowOpacity = config.shadowOpacity
        view.layer.cornerRadius = config.cornerRadius
        view.clipsToBounds = true
    }
}
