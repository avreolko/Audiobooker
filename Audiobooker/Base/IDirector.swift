//
//  IDirector.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 21/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

protocol IDirector
{
    associatedtype RootViewController: UIViewController
    func assembly()
    func viewIsReady()
    func viewWillClose()
}
