//
//  IStorage.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 01/07/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

public protocol IStorage: AnyObject {
    func fetch<T: Codable>(for key: String) -> T?
    func save<T: Codable>(_ data: T, for key: String)
}
