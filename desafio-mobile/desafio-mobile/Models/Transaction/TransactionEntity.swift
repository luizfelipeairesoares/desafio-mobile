//
//  TransactionEntity.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 12/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import Mapper

struct TransactionEntity: Mappable {
    
    let value: Float?
    let number: String?
    let cvv: String?
    let date: String?
    let name: String?
    
    init(map: Mapper) throws {
        self.value = map.optionalFrom("value")
        self.number = map.optionalFrom("number")
        self.cvv = map.optionalFrom("cvv")
        self.date = map.optionalFrom("exp_date")
        self.name = map.optionalFrom("card_holder_name")
    }
}
