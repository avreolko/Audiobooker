//
//  Extensions.swift
//  Multilist
//
//  Created by Черепянко Валентин Александрович on 21/08/2018.
//  Copyright © 2018 Черепянко Валентин Александрович. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat
{
	static func random() -> CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}

extension UIColor
{
	static func random() -> UIColor {
		return UIColor(red:   .random(),
					   green: .random(),
					   blue:  .random(),
					   alpha: 1.0)
	}
}

extension String
{
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

		let boundingBox = self.boundingRect(with: constraintRect,
											options: .usesLineFragmentOrigin,
											attributes: [.font: font],
											context: nil)

		return ceil(boundingBox.height)
	}

	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)

		let boundingBox = self.boundingRect(with: constraintRect,
											options: .usesLineFragmentOrigin,
											attributes: [.font: font],
											context: nil)

		return ceil(boundingBox.width)
	}
}

extension UIColor
{
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")

		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}

	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}
}
