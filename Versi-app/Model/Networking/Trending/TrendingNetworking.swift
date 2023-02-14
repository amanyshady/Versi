//
//  TrendingNetworking.swift
//  Versi-app
//
//  Created by Amany Shady on 25/01/2023.
//

import Foundation

enum TrendingNetworking {
    
    case getTrending
    case searchRepo(searchTxt : String)
    //if need more action like update  , delete ,...
}


extension TrendingNetworking : ApiTarget {
    
    var baseUrl: String {
        
        switch self {
        default :
            return trendingRepoUrl
        }
        
    }
    
    var path: String {
        
        switch self {
        case .getTrending :
            // we just get here swift category
            return swiftTrendingSegment
            
        case .searchRepo(let searchTxt):
            
            return searchTxt + starsDescendingSegment
        }
    }
    
    var httpMethod: HttpMethod {
        
        switch self {
        case .getTrending :
            // we just get here swift category
            return .get
        case .searchRepo:
            return .get
        }
    }
    
    var task: Task {
        
        switch self {
        case .getTrending :
            // we just get here swift category
            return .requestPlain
        case .searchRepo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        switch self {
        case .getTrending :
            // we just get here swift category
            return [:]
        case .searchRepo:
            return [:]
        }
    }
    
    
    
}
