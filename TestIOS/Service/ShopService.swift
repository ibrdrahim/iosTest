//
//  ShopService.swift
//  TestIOS
//
//  Created by Ibrahim Indosystem on 1/6/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation

class ShopService{
    
    func hatList(callback : @escaping (APIResp) -> Void) {
        
        APIHandler.request(url: "http://demo9618857.mockable.io/list/hat", requestMethod: .get, requestParam: nil, useAuthorizationToken: true, checkConnection: true) { (APIResp) in
            
            callback(APIResp)
        }
        
    }
    
    func jeansList(callback : @escaping (APIResp) -> Void) {
        
        APIHandler.request(url: "http://demo9618857.mockable.io/list/jeans", requestMethod: .get, requestParam: nil, useAuthorizationToken: true, checkConnection: true) { (APIResp) in
            
            callback(APIResp)
        }
        
    }
    
    func shirtList(callback : @escaping (APIResp) -> Void) {
        
        APIHandler.request(url: "http://demo9618857.mockable.io/list/shirt", requestMethod: .get, requestParam: nil, useAuthorizationToken: true, checkConnection: true) { (APIResp) in
            
            callback(APIResp)
        }
        
    }
}
