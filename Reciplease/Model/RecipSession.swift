//
//  RecipSession.swift
//  Reciplease
//
//  Created by AMIMOBILE on 28/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import Alamofire

class RecipSession {
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            completionHandler(responseData)
        }
    }

}
