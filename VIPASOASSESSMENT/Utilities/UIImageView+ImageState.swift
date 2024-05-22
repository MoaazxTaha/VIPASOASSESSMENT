//
//  UIImage+ImageState.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

public enum ImageState {
    /// Image is loading
    case loading
    /// Image has been loaded. No associated value, as AFImage already sets the image in the image view in `downloadImageAsync`
    case loaded
    /// Image loading has failed
    case failed
}

public extension UIImageView {
    private static let noImageImage = Images.emptyStateImage.image
    private static let loadingImage = Images.emptyStateImage.image

    func setImageState(_ state: ImageState?) {
        switch state {
        case .loading:
            image = Self.loadingImage
            backgroundColor = nil
        case .loaded:
            backgroundColor = nil
        case .failed,
             .none:
            image = Self.noImageImage
            backgroundColor = Colors.primaryGray.color
        }
    }
}
