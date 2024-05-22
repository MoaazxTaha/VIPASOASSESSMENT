//
//  Config.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

enum Config {
    static var baseURL: String {
        guard let baseURLString = Bundle.main.infoDictionary!["BaseUrl"] as? String else {
            fatalError("Info.plist does not contain the key _BaseUrl. Add this key with value $(BASE_URL)")
        }
        return baseURLString
    }
}
