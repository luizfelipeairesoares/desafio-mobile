//
//  ProductEntity.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import Mapper

struct ProductEntity: Mappable {
    
    let title: String?
    let price: Float?
    let zipcode: String?
    let seller: String?
    let thumbnail: URL?
    let date: String?
    
    init(map: Mapper) throws {
        self.title      = map.optionalFrom("title")
        self.price      = map.optionalFrom("price")
        self.zipcode    = map.optionalFrom("zipcode")
        self.seller     = map.optionalFrom("seller")
        self.thumbnail  = map.optionalFrom("thumbnailHd")
        self.date       = map.optionalFrom("date")
    }
    
}
