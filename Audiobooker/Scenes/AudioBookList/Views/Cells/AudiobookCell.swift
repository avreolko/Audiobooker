//
//  AudioBookCell.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 03/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class AudioBookCell: UITableViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIViewDecorator.decorate(view: cover,
                                 config: UIViewDecoratorConfig.audioBookCover)
    }
    
    func setCoverPath(_ coverPath: URL) {
        do {
            let imageDataFromURL = try Data(contentsOf: coverPath)
            let image = UIImage(data: imageDataFromURL, scale: UIScreen.main.scale)
            self.cover.image = image
        } catch {
            print("Can't find cover of this audiobook. Path: \(coverPath.absoluteString)")
        }
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func setAuthor(_ author: String) {
        self.author.text = author
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        print("selected \(self.title.text!) - \(selected)")
    }
}
