//
//  UserListResponse.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

struct UserListResponse: Codable {
    let usersList: [UserInfo]
    
    enum CodingKeys: String, CodingKey {
        case usersList = "items"
    }
}
