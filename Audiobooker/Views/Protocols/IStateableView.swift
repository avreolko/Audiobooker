//
//  IStateableView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 20/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import UIKit

protocol IStateable: AnyObject {
    var state: Codable { get }
    var key: IStorageKey { get }
    func encode(state: Codable)
}

extension IStateable {
    // call it on dealloc
    func encode<T: Codable>(state: T) {
        let storage = DefaultsStorage()
        storage.save(state, for: self.key)
    }
    
    // call it whenever you need to restore state
    func decodeState<T: Codable>() -> T? {
        let storage = DefaultsStorage()
        return storage.fetch(for: self.key)
    }
}

