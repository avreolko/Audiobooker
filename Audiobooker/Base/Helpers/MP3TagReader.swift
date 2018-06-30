//
//  MP3TagReader.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 04/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation
import AVKit

class MP3TagContainer: IMP3TagContainer {
    private let asset: AVAsset
    
    required init(pathToMP3File: URL) {
        self.asset = AVAsset(url: pathToMP3File)
    }
    
    lazy var tags: [String : String] = {
        var metaDataDictionary = [String : String]()
        
        for metaDataItem in asset.commonMetadata {
            let value: String = metaDataItem.value as? String ?? ""
            let key: String = metaDataItem.key as? String ?? ""
            
            if let key = metaDataItem.key as? String, let value = metaDataItem.value as? String {
                metaDataDictionary[key] = value
            }
        }
        
        return metaDataDictionary
    }()
    
    var title: String {
        return tags["TIT2"] ?? ""
    }
    
    var album: String {
        return tags["TALB"] ?? ""
    }
    
    var artist: String {
        return tags["TPE1"] ?? ""
    }
}
