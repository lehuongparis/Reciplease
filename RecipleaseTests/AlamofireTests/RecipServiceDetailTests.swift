//
//  RecipServiceDetailTests.swift
//  RecipleaseTests
//
//  Created by AMIMOBILE on 27/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipServiceDetailTests: XCTestCase {

    func testGetRecipDetailShouldPostFailedCallbackIfError() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecipDetail(id: "Perfect-Homemade-Alfredo-Sauce-2643296") { success, recipDetail in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipDetailShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecipDetail(id: "Perfect-Homemade-Alfredo-Sauce-2643296") { success, recipDetail in
            XCTAssertFalse(success)
            XCTAssertNil(recipDetail)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipDetailShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctDataRecipDetail, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecipDetail(id: "Perfect-Homemade-Alfredo-Sauce-2643296") { success, recipDetail in
            XCTAssertFalse(success)
            XCTAssertNil(recipDetail)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipDetailShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecipDetail(id: "Perfect-Homemade-Alfredo-Sauce-2643296") { success, recipDetail in
            XCTAssertFalse(success)
            XCTAssertNil(recipDetail)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipDetailShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctDataRecipDetail, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecipDetail(id: "Perfect-Homemade-Alfredo-Sauce-2643296") { success, recipDetail in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipDetail)
            XCTAssertEqual(recipDetail?.id, "Perfect-Homemade-Alfredo-Sauce-2643296")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
