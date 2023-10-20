//
//  View.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

extension UIView {

    func setupGradient(colors: [UIColor]) {

        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 1, y: 0)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map({$0.cgColor})
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.cornerRadius = layer.frame.height / 2

        if let oldValue = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldValue, with: gradientLayer)
        }
        else {
            layer.insertSublayer(gradientLayer, below: nil)
        }

        layer.shadowColor = UIColor.appleGreen40Color.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.frame.height / 2).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0

    }

}
