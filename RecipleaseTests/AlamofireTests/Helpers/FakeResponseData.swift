//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by AMIMOBILE on 22/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.


import Foundation

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    static var correctDataRecips: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recips", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var correctDataRecipDetail: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipDetail", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
}
