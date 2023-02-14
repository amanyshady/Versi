//
//  ApiConfig.swift
//  Versi-app
//
//  Created by Amany Shady on 24/01/2023.
//

import Foundation
import Alamofire


//set common configuration of any api request

enum HttpMethod : String {
    
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum Task {
    
    case requestPlain   // simple request with just url without parameters
    case requestParameters(parameters : [String : Any] , encoding : ParameterEncoding)
}


protocol ApiTarget {
    
    var baseUrl  : String { get }
    
    var path  : String { get }
    
    var httpMethod : HttpMethod { get }
    
    var task : Task { get }
    
    var headers : [String : String]? { get }
    
    
}
