//
//  StorageTest.swift
//  AudiobookerTests
//
//  Created by Valentin Cherepyanko on 01/07/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import XCTest

class StorageTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExample() {
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }

}
