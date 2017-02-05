//
//  ProductService.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper

struct ProductService {
    
    private let provider: MoyaProvider<DesafioAPI> = MoyaProvider<DesafioAPI>(endpointClosure: { (target: DesafioAPI) -> Endpoint<DesafioAPI> in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint: Endpoint<DesafioAPI> = Endpoint<DesafioAPI>(url: url,
                                                                  sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                                                    method: target.method,
                                                                    parameters: target.parameters,
                                                                    parameterEncoding: target.parameterEncoding,
                                                                    httpHeaderFields: nil)
        return endpoint
    }, plugins: [NetworkLoggerPlugin(verbose: true)])
    
    // MARK: - Requests
    
    internal func requestProducts(completion: @escaping (Result<[ProductEntity], String>) -> Void) {
        self.provider.request(.products) { (result) in
            switch result {
            case .success(let response):
                do {
                    let entity: [ProductEntity] = try response.mapArray() as [ProductEntity]
                    completion(Result.success(entity))
                } catch {
                    completion(Result.failure(MoyaError.statusCode(response).localizedDescription))
                }
            case .failure(let error):
                completion(Result.failure(error.localizedDescription))
            }
        }
    }
    
    internal func buyProduct(product: ProductEntity, completion: @escaping (Result<Bool, String>) -> Void) {
        
    }
}
