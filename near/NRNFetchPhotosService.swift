//
//  NRNFetchPhotosService.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire
import SwiftyJSON

class NRNFetchPhotosService: LHNetworkServiceable {
    var route: LHNetworkRouteType {
        return NRNPhotosRoute.fetchPhotos(longitude: longitude, latitude: latitude)
    }
    var networkClient: LHNetworkClientType = NRNetworkClient.default
    
    internal var longitude: String = ""
    internal var latitude: String = ""
    
    func request(longitude: String, latitude: String, completionHandler: @escaping (Result<[NRNPhoto]>) -> Void) {
        self.longitude = longitude
        self.latitude = latitude
        
        self.networkClient.request(networkRequest: self.route.networkRequest) { (result) in
            switch result {
            case .success(let json):
                
                let photos = json.array?.flatMap({ (json: JSON) -> NRNPhoto? in
                    if let photo = NRNPhoto(json: json) {
                        return photo
                    } else {
                        return nil
                    }
                })
            
                if let photos = photos {
                    completionHandler(Result.success(photos))
                } else {
                    completionHandler(Result.failure(NRParsingError.parsingFailure))
                }
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
}
