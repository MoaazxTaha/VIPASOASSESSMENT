//
//  UsersListViewModel.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import MessageUI
import RxCocoa
import RxSwift

class UsersSearchViewModel {
    // MARK: - public properties
    var fetchedUsersList: BehaviorRelay<[UserInfo]> = .init(value: [])
    var searchTerm: BehaviorRelay<String> = .init(value: Strings.usersSearchIntialValue)
    var viewState: BehaviorRelay<ViewState> = BehaviorRelay(value: .loading)
    
    // MARK: - private properties
    private let getHeadlinesSubject = PublishSubject<Void>()
    private let disposalBag = DisposeBag()
    
    // MARK: - Init
    init() {
        viewState.accept(.loading)
        loadData()
        setupBinding()
    }
    
    // MARK: - Load Data
    func loadData() {
        viewState.accept(.loading)
        let userListRequest: Single<UserListResponse> = API.UsersList(searchTerm: searchTerm.value).request()
        
        userListRequest
            .subscribe(onSuccess: { [weak self] userListRespnse in
                self?.fetchedUsersList.accept(userListRespnse.usersList)
            }, onFailure: { [weak self] error in
                self?.viewState.accept(.error(error))

            })
            .disposed(by: disposalBag)
    }
    
    // MARK: - Search Handling
    
    private func setupBinding() {
        searchTerm
            .debounce(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .subscribe { [weak self] _ in
                self?.loadData()
            }
            .disposed(by: disposalBag)
        
        fetchedUsersList
            .subscribe { [weak self] searchResult in
                self?.viewState.accept(.loaded(searchResult))
            }
            .disposed(by: disposalBag)
    }
}
