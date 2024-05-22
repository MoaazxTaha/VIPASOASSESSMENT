//
//  UIView+Builder.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

public protocol Builder {}

public extension Builder {
    /// Usage:
    /// let imageView = UIImageView().with {
    ///     $0.image = UIImage(named: "builderExample")
    /// }
    func with(configure: (inout Self) -> Void) -> Self {
        var this = self
        configure(&this)
        return this
    }
}

extension NSObject: Builder {}
