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
        view.layer.cornerRadius = config.cornerRadius
        view.layer.shadowColor = config.shadowColor
        view.layer.shadowRadius = config.shadowRadius
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        
        if config.blur {
            self.blur(view: view, config: config)
        }
    }
    
    private static func blur(view: UIView, config: UIViewDecoratorConfig) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.layer.cornerRadius = config.cornerRadius
        blurEffectView.clipsToBounds = true
        
        view.insertSubview(blurEffectView, at: 0)
    }
}
