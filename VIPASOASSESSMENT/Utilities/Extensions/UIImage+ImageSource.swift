//
//  UIImage+ImageSource.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func apply(_ imageSource: ImageSource) {
        switch imageSource {
        case .asset(let image):
            self.image = image
        case .url(let url):
            imageSource.downloadImage(fromURL: URL(string: url)) { [weak self] image in
                guard let self, let image else { return }
                self.image = image
            }
        }
    }
}
