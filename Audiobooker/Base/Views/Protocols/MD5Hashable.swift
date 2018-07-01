//
//  MD5Hashable.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 01/07/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit
import CommonCrypto

enum HasherError: Error {
    case seedError
    case hashError
    case unknownError
}

protocol MD5Hashable {
    var seed: String { get }
    func md5Hash() throws -> String
}

extension MD5Hashable {
//    func md5Hash() throws -> String  {
//        guard let messageData = self.seed.data(using:.utf8) else {
//            throw HasherError.seedError
//        }
//
//        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
//
//        _ = digestData.withUnsafeMutableBytes {digestBytes in
//            messageData.withUnsafeBytes {messageBytes in
//                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//            }
//        }
//
//        guard let hashString = String(data: digestData, encoding: .utf8) else {
//            throw HasherError.hashError
//        }
//
//        return hashString
//    }
    
    func md5Hash() throws -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.seed.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
