//
//  Repo.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation

struct Repo: Codable {
    var id: Int
    var name: String
    var stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case stargazersCount = "stargazers_count"
    }
    
    init(id: Int, name: String, stargazersCount: Int) {
        self.id = id
        self.name = name
        self.stargazersCount = stargazersCount
    }
}
