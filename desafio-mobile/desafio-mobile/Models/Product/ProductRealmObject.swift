//
//  ProductRealmObject.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 05/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit
import RealmSwift

class ProductRealmObject: Object {
    
    dynamic var title: String = ""
    dynamic var price: Float = 0.0
    dynamic var zipcode: String = ""
    dynamic var seller: String = ""
    dynamic var thumbnail: String = ""
    dynamic var date: String = ""
    
    override var description: String {
        return "{\(title), \(price), \(zipcode), \(seller), \(thumbnail), \(date)}"
    }

}
