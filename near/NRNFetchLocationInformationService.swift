//
//  NRNFetchLocationInformationService.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire

class NRNFetchLocationInformationService: LHNetworkServiceable {
    var route: LHNetworkRouteType {
        return NRNLocationRoute.fetchLocationInformation(longitude: longitude, latitude: latitude)
    }
    var networkClient: LHNetworkClientType = NRNetworkClient.default
    
    internal var longitude: String = ""
    internal var latitude: String = ""
    
    func request(longitude: String, latitude: String, completionHandler: @escaping (Result<NRNLocation>) -> Void) {
        self.longitude = longitude
        self.latitude = latitude
        
        self.networkClient.request(networkRequest: self.route.networkRequest) { (result) in
            switch result {
            case .success(let json):
                if let location = NRNLocation(json: json) {
                    completionHandler(Result.success(location))
                } else {
                    
                    completionHandler(Result.failure(NRParsingError.parsingFailure))
                }
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
