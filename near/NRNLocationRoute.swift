//
//  NRNLocationRoute.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire

enum NRNLocationRoute: LHNetworkRouteType {
    
    case `default`
    /// Fetch location information with weather status by given longitude and latitude.
    case fetchLocationInformation(longitude: String, latitude: String)
    
    // MARK: - LHNetworkRouteType
    
    var rootEndpoint: String { return "location" }
    var mainEndpoint: String {
        switch self {
        case .fetchLocationInformation:
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
        case .fetchLocationInformation(let longitude, let latitude):
            return ["longitude": longitude, "latitude": latitude]
        default:
            return [:]
        }
    }
}
