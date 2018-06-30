//
//  IAppStateListener.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 30/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

@objc protocol IAppStateListener: AnyObject {
    func appBecomeActive()
    func appBecomeNonActive()
    func appBecomeUnknown()
}
