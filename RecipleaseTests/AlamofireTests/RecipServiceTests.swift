//
//  RecipServiceTests.swift
//  RecipleaseTests
//
//  Created by AMIMOBILE on 22/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.


import XCTest
@testable import Reciplease

class RecipServiceTests: XCTestCase {
    
    func testGetRecipsShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecips(allowedIngreString: "&allowedIngredient[]=lemon") { success, recip in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipsShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecips(allowedIngreString: "&allowedIngredient[]=lemon") { success, recip in
            XCTAssertFalse(success)
            XCTAssertNil(recip)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipsShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctDataRecips, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecips(allowedIngreString: "&allowedIngredient[]=lemon") { success, recip in
            XCTAssertFalse(success)
            XCTAssertNil(recip)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipsShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecips(allowedIngreString: "&allowedIngredient[]=lemon") { success, recip in
            XCTAssertFalse(success)
            XCTAssertNil(recip)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipsShouldPostSuccesCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctDataRecips, error: nil)
        let recipSessionFake = RecipSessionFake(fakeResponse: fakeResponse)
        let recipService = RecipService(recipSession: recipSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipService.getRecips(allowedIngreString: "&allowedIngredient[]=lemon&allowedIngredient[]=curry&allowedIngredient[]=salad") { success, recip in
            XCTAssertTrue(success)
            XCTAssertNotNil(recip)
            XCTAssertEqual(recip?.matches.first?.id, "Grilled-Curry-Stuffed-Avocados-2148772")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
