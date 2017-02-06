//
//  NRNPhotosRoute.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire

enum NRNPhotosRoute: LHNetworkRouteType {
    
    case `default`
    /// Fetch photos by given longitude and latitude.
    case fetchPhotos(longitude: String, latitude: String)
    
    // MARK: - LHNetworkRouteType
    
    var rootEndpoint: String { return "photos" }
    var mainEndpoint: String {
        switch self {
        case .fetchPhotos:
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
        case .fetchPhotos(let longitude, let latitude):
            return ["longitude": longitude, "latitude": latitude]
        default:
            return [:]
        }
    }
}
