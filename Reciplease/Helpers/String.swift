//
//  String.swift
//  Reciplease
//
//  Created by AMIMOBILE on 02/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Change String to Array of String
    var stringToArrayString: [String] {
        get {
            return self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter { !$0.isEmpty }
        }
    }
    
    // MARK: - Change String to String with Capital Letter
    var stringToFirstCapitalLetter: String {
        get {
           return self.prefix(1).capitalized + self.dropFirst()
        }
    }
    
    // MARK: - String in Data
    var stringImagetoDataImage: Data? {
        get {
            if let imageURL = URL(string: self) {
               let imageData = try? Data(contentsOf: imageURL)
                return imageData
            } else {
                return nil
            }
        }
    }
    
    
}
