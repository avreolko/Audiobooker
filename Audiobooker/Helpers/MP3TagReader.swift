//
//  MP3TagReader.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 04/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import Foundation

class MP3TagContainer: IMP3TagContainer {
    private var id3Tag: ID3Tag?
    
    required init(pathToMP3File: URL) {
        do {
            let id3TagEditor = ID3TagEditor()
            
            if let id3Tag = try id3TagEditor.read(from: pathToMP3File) {
                self.id3Tag = id3Tag
            }
        } catch {
            print(error)
        }
    }
    
    var title: String {
        return self.id3Tag?.title ?? ""
    }
    
    var album: String {
        return self.id3Tag?.album ?? ""
    }
    
    var artist: String {
        return self.id3Tag?.artist ?? ""
    }
    
    var albumArtist: String {
        return self.id3Tag?.albumArtist ?? ""
    }
}
