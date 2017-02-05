//
//  Result.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation

enum Result<T, String> {
    case success(T)
    case failure(String)
}
