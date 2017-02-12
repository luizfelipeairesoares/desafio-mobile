//
//  ProductsViewModel.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 30/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import RealmSwift

protocol ProductProtocol: class, ControllersProtocol {
    func reloadTable()
}

class ProductsViewModel {
    
    private weak var controller: ProductProtocol?
    
    internal func assignController(controller: ProductProtocol) {
        self.controller = controller
    }
    
    internal var products: [ProductEntity] = []
    
    internal var cart: [ProductEntity] = [] 
    
    // MARK: - Request Methods
    
    internal func requestProducts() {
        self.controller?.showLoading()
        ProductService().requestProducts { (result) in
            switch result {
            case .success(let products):
                self.products = products
                self.controller?.reloadTable()
            case .failure(let msg):
                self.controller?.showAlert(title: "Desafio", message: msg)
            }
        }
    }
    
    internal func buyProducts(name: String, number: String, cvv: String, valid: String) {
        self.controller?.showLoading()
        
        let arr = number.components(separatedBy: " ")
        
        let last = arr[3]
        
        var total: Float = 0.0
        
        for product in self.cart {
            if let price = product.price {
                total += price
            }
        }
        
        let json: [String : AnyObject] = ["card_number" : number as AnyObject,
                                          "cvv" : cvv  as AnyObject,
                                          "card_holder_name" : name  as AnyObject,
                                          "exp_date" : valid  as AnyObject]
        
        let entity = TransactionEntity.from(json as NSDictionary)
        
        ProductService().buyProduct(transaction: entity!) { [unowned self] (result) in
            switch result {
            case .success(let transaction):
                print(transaction)
                self.saveTransaction(name: name, total: total, last: last)
            case .failure(let msg):
                self.controller?.showAlert(title: "", message: msg)
            }
        }
    }
    
    private func saveTransaction(name: String, total: Float, last: String) {
        var error: Bool =  false
        
        let realm = try! Realm()
    
        let transaction = TransactionRealmObject()
        transaction.date = Date()
        transaction.value = total
        transaction.number = last
        transaction.name = name
    
        do {
        try realm.write {
            realm.add(transaction, update: false)
            }
        } catch (let err) {
            print("\(err)")
            error = true
        }
        
        self.controller?.hideLoading()
        if error == false {
            self.controller?.showAlert(title: "", message: "Compra efetuada com sucesso!")
            self.cart.removeAll()
            self.controller?.reloadTable()
        } else {
            self.controller?.showAlert(title: "", message: "Um erro ocorreu ao processar sua compra")
        }
    }
}
