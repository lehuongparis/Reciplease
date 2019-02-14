//
//  Recip.swift
//  Reciplease
//
//  Created by AMIMOBILE on 16/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation

struct Recip: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    var recipeName: String
    var ingredients: [String]
    var id: String
    var rating: Int
    var totalTimeInSeconds: Int
    var smallImageUrls: [String]
}









