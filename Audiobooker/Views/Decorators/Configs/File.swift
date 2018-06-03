//
//  UIViewDecoratorConfig.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

struct UIViewDecoratorConfig {
    var cornerRadius: CGFloat
    var shadowOpacity: Float
    var backgroundColor: UIColor
    var shadowColor: CGColor
    var shadowRadius: CGFloat
    
    static let basic: UIViewDecoratorConfig = {
        let config = UIViewDecoratorConfig(cornerRadius: 3,
        shadowOpacity: 0.2,
        backgroundColor: .clear,
        shadowColor: UIColor.black.cgColor,
        shadowRadius: 2)
        
        return config
    }()
    
    static let audioBookCover: UIViewDecoratorConfig = {
        let config = UIViewDecoratorConfig(cornerRadius: 5,
                                           shadowOpacity: 0.2,
                                           backgroundColor: .clear,
                                           shadowColor: UIColor.black.cgColor,
                                           shadowRadius: 2)
        
        return config
    }()
}
