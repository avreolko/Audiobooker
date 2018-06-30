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
    var blur: Bool
    
    public init (cornerRadius: CGFloat,
                 shadowOpacity: Float,
                 backgroundColor: UIColor,
                 shadowColor: CGColor,
                 shadowRadius: CGFloat,
                 blur: Bool = false) {
        self.cornerRadius = cornerRadius
        self.shadowOpacity = shadowOpacity
        self.backgroundColor = backgroundColor
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.blur = blur
    }
    
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
                                           shadowOpacity: 0.5,
                                           backgroundColor: .white,
                                           shadowColor: UIColor.black.cgColor,
                                           shadowRadius: 5)
        
        return config
    }()
    
    static let bigPanel: UIViewDecoratorConfig = {
        let config = UIViewDecoratorConfig(cornerRadius: 5,
                                           shadowOpacity: 0.2,
                                           backgroundColor: .black,
                                           shadowColor: UIColor.black.cgColor,
                                           shadowRadius: 5)
        
        return config
    }()
    
    static let darkBlur: UIViewDecoratorConfig = {
        let config = UIViewDecoratorConfig(cornerRadius: 5,
                                           shadowOpacity: 0.2,
                                           backgroundColor: .clear,
                                           shadowColor: UIColor.black.cgColor,
                                           shadowRadius: 5,
                                           blur: true)
        
        return config
    }()
    
    static let player: UIViewDecoratorConfig = {
        let config = UIViewDecoratorConfig(cornerRadius: 5,
                                           shadowOpacity: 0.2,
                                           backgroundColor: .black,
                                           shadowColor: UIColor.gray.cgColor,
                                           shadowRadius: 5)
        
        return config
    }()
}
