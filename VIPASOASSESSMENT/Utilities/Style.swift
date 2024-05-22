//
//  Style.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

// MARK: - Style: text style config

public class Style {
    let font: UIFont
    let color: UIColor
    
    public init(font: UIFont, color: UIColor = Colors.primaryBody.color) {
        self.font = font
        self.color = color
    }
}
