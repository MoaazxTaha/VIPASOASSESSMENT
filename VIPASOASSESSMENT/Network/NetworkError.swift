//
//  NetworkError.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case connectionFailure
    case timeout
    case invalidResponse(Int)
    case dataParsingFailure

    init(errorCode: Int) {
        if !NetworkConnectivity.shared.isConnected {
            self = .connectionFailure
        } else {
            switch errorCode {
            case 400 ... 404:
                self = .invalidURL
            case 408:
                self = .timeout
            default:
                self = .invalidResponse(errorCode)
            }
        }
    }
}
