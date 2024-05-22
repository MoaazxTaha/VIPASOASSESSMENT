//
//  UnitTestMockData.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 22/05/2024.
//

import Foundation

class UnitTestMockData {

    var userInfo: UserInfo = .init(id: 12345678,
                                   userName: "mock",
                                   avatarUrl: "https://avatars.githubusercontent.com/u/690557?v=4",
                                   reposURL: "https://api.github.com/users/mock/repos")
    var repos: [Repo] = [
        .init(id: 11111111, name: "MOCKREPO 1", stargazersCount: 0),
        .init(id: 22222222, name: "MOCKREPO 2", stargazersCount: 1),
        .init(id: 33333333, name: "MOCKREPO 3", stargazersCount: 2)
    ]
}
