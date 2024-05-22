//
//  Style+PrimaryComponent.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

extension Style {
    enum text {
        /// Body (size: 14, weight: regular, color: primary)
        static let bodyS = Style.init(font: .bodyS, color: Colors.primaryBody.color)
        /// Body (size: 16, weight: regular, color: primary)
        static let bodyM = Style.init(font: .bodyM, color: Colors.primaryBody.color)
        /// Body (size: 18, weight: regular, color: primary)
        static let bodyL = Style.init(font: .bodyL, color: Colors.primaryBody.color)

        /// HeadLine (size: 16, weight: bold, color: primary)
        static let headLineS = Style.init(font: .headLineS, color: Colors.primaryBody.color)
        /// HeadLine (size: 18, weight: bold, color: primary)
        static let headLineM = Style.init(font: .headLineM, color: Colors.primaryBody.color)
        /// HeadLine (size: 20, weight: bold, color: primary)
        static let headLineL = Style.init(font: .headLineL, color: Colors.primaryBody.color)
    }
    
    enum padding {
        /// 4
        static let half: CGFloat = 4.0
        /// 8
        static let single: CGFloat = 8.0
        /// 12
        static let medium: CGFloat = 12.0
        /// 16
        static let double: CGFloat = 16.0
        /// 24
        static let triple: CGFloat = 24.0
    }
    
    enum CornerRadius {
        /// 3
        public static let half: CGFloat = 3.0
        /// 5
        public static let single: CGFloat = 5.0
        /// 10
        public static let double: CGFloat = 10.0
        /// 15
        public static let triple: CGFloat = 15.0
    }
    
    enum EdgeInset {
        /// 4
        static let half: UIEdgeInsets = .init(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        /// 8
        static let single: UIEdgeInsets = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        /// 12
        static let medium: UIEdgeInsets = .init(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
        /// 16
        static let double: UIEdgeInsets = .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        /// 24
        static let triple: UIEdgeInsets = .init(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)

    }
}
