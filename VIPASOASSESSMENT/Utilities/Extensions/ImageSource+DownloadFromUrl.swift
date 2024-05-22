//
//  UIImage+Resize.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import UIKit

extension ImageSource {
    func downloadImage(fromURL url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let image = UIImage(data: data)
            completion(image)
        }

        task.resume()
    }
}
