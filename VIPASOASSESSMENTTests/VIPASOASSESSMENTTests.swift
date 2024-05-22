//
//  VIPASOASSESSMENTTests.swift
//  VIPASOASSESSMENTTests
//
//  Created by Moaaz Ahmed Fawzy Taha on 22/05/2024.
//

import XCTest
@testable import VIPASOASSESSMENT

final class VIPASOASSESSMENTTests: XCTestCase {

    var sut: UserDetailViewMdoel!
    var mockData: UnitTestMockData!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockData = UnitTestMockData()
        sut = UserDetailViewMdoel(userInfo: mockData.userInfo)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockData = nil
        try super.tearDownWithError()
    }

    func testStarsCountFunction() throws {
        // Given
        let repos = mockData.repos
        
        // When
        let starsCount = sut.countUserStars(in: repos)
        
        // Then
        XCTAssertEqual(starsCount, 3)
    }
}
