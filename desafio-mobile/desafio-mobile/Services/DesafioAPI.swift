//
//  DesafioAPI.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import Moya

public enum DesafioAPI {
    
    // MARK: - GET
    case products
    
}

extension DesafioAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/stone-pagamentos/desafio-mobile/master/") ?? URL(string: "")!
    }
    
    public var path: String {
        switch self {
        case .products:
            return "products.json"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String : Any]? {
        return nil
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        return URLEncoding()
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .request
    }
}
