//
//  NRNSpotsRoute.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire

enum NRNSpotsRoute: LHNetworkRouteType {
    
    case `default`
    /// Fetch spots by given longitude and latitude.
    case fetchSpots(longitude: String, latitude: String)
    
    // MARK: - LHNetworkRouteType
    
    var rootEndpoint: String { return "spots" }
    var mainEndpoint: String {
        switch self {
        case .fetchSpots:
            return ""
        default:
            return ""
        }
    }
    var method: HTTPMethod {
        return .get
    }
    var parameters: [String : Any] {
        switch self {
        case .fetchSpots(let longitude, let latitude):
            return ["longitude": longitude, "latitude": latitude]
        default:
            return [:]
        }
    }
}

