//
//  TransactionRealmObject.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 05/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionRealmObject: Object {
    
    dynamic var value: Float = 0.0
    dynamic var number: String = ""
    dynamic var date: Date = Date()
    dynamic var name: String = ""
    
    override var description: String {
        return "{\(value), \(number), \(date), \(name)}"
    }

}
