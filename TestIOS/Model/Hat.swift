//
//  Hat.swift
//  TestIOS
//
//  Created by Ibrahim Indosystem on 1/6/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation

import ObjectMapper

class Hat :Mappable{
    var id:Int?
    var name:String?
    var brand:String?
    var imageUrl:String?
    var description:String?
    var price:String?
    
    required init?(map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id                  <- map["id"]
        name                  <- map["name"]
        brand                  <- map["brand"]
        imageUrl                  <- map["image_url"]
        description                  <- map["description"]
        price                  <- map["price"]
    }
    
}
