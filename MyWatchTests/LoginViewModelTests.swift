//
//  LoginViewModelTests.swift
//  MyWatchTests
//
//  Created by Amir Malamud on 03/02/2023.
//

import XCTest
@testable import MyWatch

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        viewModel = LoginViewModel(phoneNumber: "+1 650-253-0000", password: "123456")
    }
    
    func testPhoneNumber() {
        XCTAssertEqual(viewModel.phoneNumber, "+1 650-253-0000")
    }
    
    func testPassword() {
        XCTAssertEqual(viewModel.password, "123456")
    }
    
    func testLogin() {
        let expectation = XCTestExpectation(description: "Login with valid credentials")
        viewModel.login { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Login failed")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
