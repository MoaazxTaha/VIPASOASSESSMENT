//
//  UserInfo.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

import Foundation

struct UserInfo: Identifiable, Codable {
    let id: Int
    let userName: String
    let avatarUrl: String
    let reposURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarUrl = "avatar_url"
        case reposURL = "repos_url"
    }

    
}

