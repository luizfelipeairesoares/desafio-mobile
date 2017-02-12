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
    
    private let apiaryProvider: MoyaProvider<ApiaryAPI> = MoyaProvider<ApiaryAPI>(endpointClosure: { (target: ApiaryAPI) -> Endpoint<ApiaryAPI> in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint: Endpoint<ApiaryAPI> = Endpoint<ApiaryAPI>(url: url,
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
    
    internal func buyProduct(transaction: TransactionEntity, completion: @escaping (Result<TransactionEntity, String>) -> Void) {
        let params: [String : AnyObject] = ["card_number" : transaction.number! as AnyObject,
                                            "value" : transaction.value! as AnyObject,
                                            "cvv" : transaction.cvv! as AnyObject,
                                            "card_holder_name" : transaction.name! as AnyObject,
                                            "exp_date" : transaction.date! as AnyObject]
        self.apiaryProvider.request(.buy(params: params)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let entity: TransactionEntity = try response.mapObject() as TransactionEntity
                    completion(Result.success(entity))
                } catch {
                    completion(Result.failure(MoyaError.statusCode(response).localizedDescription))
                }
            case .failure(let error):
                completion(Result.failure(error.localizedDescription))
            }
        }
    }
}
