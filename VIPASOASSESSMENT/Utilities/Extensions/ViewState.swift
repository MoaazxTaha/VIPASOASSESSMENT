//
//  ViewState.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

enum ViewState {
    case loading
    case loaded([Codable])
    case error(Error)
}
