//
//  ApiaryAPI.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 12/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import Moya

public enum ApiaryAPI {
    
    // MARK: - GET
    case buy(params: [String : AnyObject])
    
}

extension ApiaryAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://polls.apiblueprint.org/") ?? URL(string: "")!
    }
    
    public var path: String {
        switch self {
        case .buy(_):
            return "products/buy"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .buy(let params):
            return params
        default:
            return nil
        }
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        switch self.method {
        case .post:
            return JSONEncoding()
        default:
            return URLEncoding()
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .request
    }
}
