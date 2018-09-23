//
//  CircularProgressView.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 23/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

class CircularProgressView: UIView
{
    @IBInspectable var barColor = UIColor.green

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCircles()
    }

    // between 0 and 1
    var progress: Float = 0 {
        didSet {
            assert(progress <= 1 && progress >= 0)

            self.animate(to: progress)
        }
    }

    private var circleLayer = CAShapeLayer()
    private var backLayer = CAShapeLayer()
}

private extension CircularProgressView
{
    func drawCircle(on layer: CAShapeLayer, with color: UIColor, strokeEnd: CGFloat) {
        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let radius = (frame.size.width - 10) / 2
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: CGFloat(-Float.pi / 2),
                                      endAngle: CGFloat(Float.pi * 1.5),
                                      clockwise: true)

        layer.path = circlePath.cgPath
        layer.fillColor = UIColor.black.cgColor

        layer.strokeColor = color.cgColor // UIColor.red.cgColor
        layer.lineWidth = 5.0;
        layer.strokeEnd = strokeEnd
    }

    func configureCircles() {
        drawCircle(on: backLayer, with: UIColor(rgb: 0xCECECE), strokeEnd: 1)
        drawCircle(on: circleLayer, with: UIColor(rgb: 0x00ff99), strokeEnd: 0)

        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(circleLayer)
    }

    func animate(to value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.duration = 0.5

        animation.fromValue = 0
        animation.toValue = value

        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleLayer.strokeEnd = CGFloat(value)
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
