//
//  UILabel+Style.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

public extension UILabel {
    
    // apply font and colors to label using Style
    func apply(_ style: Style) {
        font = style.font
        tintColor = style.color
    }
}
