//
//  RecipService.swift
//  Reciplease
//
//  Created by AMIMOBILE on 16/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import Alamofire

class RecipService {

    // MARK: - vars, lets
    let constant = Constants()
    private var recipSession: RecipSession
    
    // MARK: - init
    init(recipSession: RecipSession = RecipSession()) {
        self.recipSession = recipSession
    }

    // Mark: - Methods
    func getRecips(allowedIngreString: String, completionHandler: @escaping(Bool, Recip?)-> Void) {
        let appId: String = constant.appId
        let myAPI: String = constant.myAPI
        
        let urlString = "http://api.yummly.com/v1/api/recipes?_app_id=\(appId)&_app_key=\(myAPI)&requirePictures=true\(allowedIngreString)"
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        recipSession.request(url: url) { responseData in
            
                guard responseData.response?.statusCode == 200 else {
                    completionHandler(false, nil)
                    return }
                
                guard let data = responseData.data else {
                    completionHandler(false, nil)
                    return }
                
                guard let recip = try? JSONDecoder().decode(Recip.self, from: data) else {
                    completionHandler(false, nil)
                    return }
                
                completionHandler(true, recip)
            }
    }
    
    func getRecipDetail(id: String, completionHandler: @escaping(Bool, RecipDetail?) -> Void) {
        
        let appId: String = constant.appId
        let myAPI: String = constant.myAPI
        
        let urlStringDetailAPI = "http://api.yummly.com/v1/api/recipe/\(id)?_app_id=\(appId)&_app_key=\(myAPI)"

        guard let url = URL(string: urlStringDetailAPI) else { return }
        
        recipSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            
            guard let recipDetail = try? JSONDecoder().decode(RecipDetail.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipDetail)
        }
    }
}



