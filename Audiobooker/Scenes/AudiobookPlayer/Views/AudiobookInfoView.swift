//
//  AudiobookInfoView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 21/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudiobookInfoView: UIView
{
    @IBOutlet var cover: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!

    func showInfo(with audiobook: AudioBook) {
        titleLabel.text = audiobook.title
        authorLabel.text = audiobook.author

        loadCover(with: audiobook.coverPath)
    }

    func loadCover(with url: URL) {
        do {
            let imageDataFromURL = try Data(contentsOf: url)
            let image = UIImage(data: imageDataFromURL, scale: UIScreen.main.scale)

            guard let cgImage = image?.cgImage else { return }
            guard let orientation = image?.imageOrientation else { return }

            let scale = UIScreen.main.scale
            let scaledImage = UIImage(cgImage: cgImage, scale: scale, orientation: orientation)

            self.cover.image = scaledImage
        } catch {
            print("Can't find cover of this audiobook. Path: \(url.absoluteString)")
        }
    }
}
