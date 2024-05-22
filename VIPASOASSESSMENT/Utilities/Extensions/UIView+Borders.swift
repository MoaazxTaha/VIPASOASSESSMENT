//
//  UIView+Borders.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(width: CGFloat = 1.0, color: UIColor = .lightGray) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func applyCornerCurve(radius: CGFloat = Style.CornerRadius.single, type: CALayerCornerCurve = .continuous) {
        self.layer.cornerRadius = radius
        self.layer.cornerCurve = type
        self.layer.masksToBounds = true
    }
    
}
