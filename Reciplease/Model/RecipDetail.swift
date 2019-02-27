//
//  RecipDetail.swift
//  Reciplease
//
//  Created by AMIMOBILE on 06/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation

struct RecipDetail: Decodable {
    let id: String
    let name: String
    let ingredientLines: [String]
    let totalTimeInSeconds: Int
    let rating: Int
    var images: [Image]
    let source: Source
    }

struct Image: Decodable {
    var hostedLargeUrl: URL?
}

struct Source: Decodable {
    let sourceRecipeUrl: String?
}

