//
//  Storage.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 20/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
public protocol IStorageKey: CodingKey { }

public protocol IStorage: AnyObject {
    func fetch<T: Codable>(for key: String) -> T?
    func save<T: Codable>(_ data: T, for key: String)
}

final class DefaultsStorage: IStorage {
    func save<T: Codable>(_ object: T, for key: String) {
        
        let encoder = JSONEncoder()
        let userDefaults = UserDefaults.standard
        
        if let data = try? encoder.encode(object) {
            userDefaults.set(data, forKey: key)
        } else {
            userDefaults.set(object, forKey: key)
        }
    }
    
    func fetch<T: Codable>(for key: String) -> T? {
        
        let decoder = JSONDecoder()
        let userDefaults = UserDefaults.standard
        
        guard let valueAny = userDefaults.value(forKey: key) else {
            return nil
        }
        
        if let valueData = valueAny as? Data,
           let typed = try? decoder.decode(T.self, from: valueData) {
            return typed
        } else if let typedFragmentValue = valueAny as? T {
            return typedFragmentValue
        } else {
            return nil
        }
    }
}
