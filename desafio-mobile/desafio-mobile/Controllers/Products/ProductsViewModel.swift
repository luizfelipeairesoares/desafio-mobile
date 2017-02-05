//
//  ProductsViewModel.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 30/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation

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
    
    internal func buyProduct(index: Int) {
        let product = self.products[index]
        
    }
}
