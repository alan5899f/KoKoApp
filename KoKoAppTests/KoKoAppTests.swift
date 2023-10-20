//
//  KoKoAppTests.swift
//  KoKoAppTests
//
//  Created by 陳韋綸 on 2023/10/20.
//

import XCTest
@testable import KoKoApp

final class KoKoAppTests: XCTestCase {

    private let userViewModel =  UserViewModel()
    private let friendsViewModel = FriendsViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllApi() throws {

        try testUserApi()
        try testFriends1Api()
        try testFriends2Api()
        try testFriends3Api()

    }

    func testUserApi() throws {
        userViewModel.bindingApi()

        userViewModel.errorResponse = { error in
            XCTFail("userApi 返回錯誤")
        }

    }

    func testFriends1Api() throws {
        friendsViewModel.bindingApi1()

        friendsViewModel.errorResponse = { error in
            XCTFail("friendsApi1 返回錯誤")
        }

    }

    func testFriends2Api() throws {
        friendsViewModel.bindingApi2()

        friendsViewModel.errorResponse = { error in
            XCTFail("friendsApi2 返回錯誤")
        }

    }

    func testFriends3Api() throws {
        friendsViewModel.bindingApi3()

        friendsViewModel.errorResponse = { error in
            XCTFail("friendsApi3 返回錯誤")
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
