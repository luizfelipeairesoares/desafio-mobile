//
//  CellProtocol.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import UIKit

protocol CellProtocol {
    
    static func cellIdentifier() -> String
    func configureCell(object: AnyObject?)
    
}

extension CellProtocol where Self: UITableViewCell {
    
    static func cellIdentifier() -> String {
        return "\(self)Identifier"
    }
}

extension CellProtocol where Self: UICollectionViewCell {
    
    static func cellIdentifier() -> String {
        return "\(self)Identifier"
    }
    
}
