//
//  UserDetailsViewModel.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import SwiftUI
import Combine
import RxRelay
import RxSwift

class UserDetailViewMdoel: ObservableObject {
    let imageURL: String
    let userName: String
    @Published var numberOfStars: Int? = nil
    @Published var viewState: ViewState = .loading
    private var disposeBag = DisposeBag()
    
    init(userInfo: UserInfo) {
        self.imageURL = userInfo.avatarUrl
        self.userName = userInfo.userName
        fetchUserRepos(from: userInfo.reposURL)
    }
    
    func fetchUserRepos(from url: String) {
        // Replace with your backend URL
        guard let url = URL(string: url) else { return }
        
        let reposRequest: Single<[Repo]> = API.request(url: url)
        
        reposRequest
            .observe(on: MainScheduler.asyncInstance)
            .subscribe (onSuccess: { [weak self] userRepos in
                guard let self else { return }
                self.viewState = .loaded(userRepos)
                self.numberOfStars = self.countUserStars(in: userRepos)
            }, onFailure: { [weak self] error in
                self?.viewState = .error(error)
            })
            .disposed(by: disposeBag)
    }
    
    
    func countUserStars(in repos: [Repo]) -> Int {
        return repos.reduce(0) { (starsSum: Int, newRepo: Repo) -> Int in
            return starsSum + newRepo.stargazersCount
        }
    }
}

