//
//  VIPASOASSESSMENTSlowTests.swift
//  VIPASOASSESSMENTSlowTests
//
//  Created by Moaaz Ahmed Fawzy Taha on 22/05/2024.
//

@testable import VIPASOASSESSMENT
import RxSwift
import RxRelay
import XCTest

final class VIPASOASSESSMENTSlowTests: XCTestCase {

    var mockData: UnitTestMockData!
    var disposalBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockData = UnitTestMockData()
        disposalBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        mockData = nil
        disposalBag = nil
        try super.tearDownWithError()
    }

    func testSearchUserAPI() throws {
        // given
        let promise = expectation(description: "Status code: 200")
        let searchTerm = Strings.usersSearchIntialValue
        let searchRequest: Single<UserListResponse> = API.UsersList(searchTerm: searchTerm).request()
        
        // when
        searchRequest
            .subscribe { _ in
                // then
                promise.fulfill()
            } onFailure: { error in
                // then
                XCTFail("Error: \(error.localizedDescription)")
            }
            .disposed(by: disposalBag)

        wait(for: [promise], timeout: 5)
    }

    func testLoadImageFromUrlFunction() throws {
        // given
        let promise = expectation(description: "Image Loaded Succefully")
        let urlString = mockData.userInfo.avatarUrl
        let url = URL(string: urlString)
        let imageSource: ImageSource = .url(urlString)

        // when
        imageSource.downloadImage(fromURL: url) { image in
            // then
            guard image != nil
            else {
                XCTFail("Error: Failed To Load Image!!")
                return
            }

            promise.fulfill()
        }

        // 3
        wait(for: [promise], timeout: 5)
    }
}
