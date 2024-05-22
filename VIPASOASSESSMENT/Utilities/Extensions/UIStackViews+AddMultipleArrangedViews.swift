//
//  UIStackViews+AddMultipleArrangedViews.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

extension UIStackView {
    public func addArrangedSubViews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
