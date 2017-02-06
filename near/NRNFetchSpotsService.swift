//
//  NRNFetchSpotsService.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire
import SwiftyJSON

class NRNFetchSpotsService: LHNetworkServiceable {
    var route: LHNetworkRouteType {
        return NRNSpotsRoute.fetchSpots(longitude: longitude, latitude: latitude)
    }
    var networkClient: LHNetworkClientType = NRNetworkClient.default
    
    internal var longitude: String = ""
    internal var latitude: String = ""
    
    func request(longitude: String, latitude: String, completionHandler: @escaping (Result<[NRNSpot]>) -> Void) {
        self.longitude = longitude
        self.latitude = latitude
        
        self.networkClient.request(networkRequest: self.route.networkRequest) { (result) in
            switch result {
            case .success(let json):
                
                let spots = json.array?.flatMap({ (json: JSON) -> NRNSpot? in
                    if let spot = NRNSpot(json: json) {
                        return spot
                    } else {
                        return nil
                    }
                })
                
                if let spots = spots {
                    completionHandler(Result.success(spots))
                } else {
                    completionHandler(Result.failure(NRParsingError.parsingFailure))
                }
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
