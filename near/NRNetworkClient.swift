//
//  NRNetworkClient.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import Alamofire
import SwiftyJSON

struct NRNetworkClient: LHNetworkClientType {
    
    /// The default singleton of `NRNetworkClient`
    static let `default`: NRNetworkClient = {
        let client = NRNetworkClient()
        return client
    }()
    
    // MARK: - LHNetworkClientType
    
    func request<Request : DataRequest>(networkRequest: Request, completionHandler: @escaping (Result<JSON>) -> Void) {
        networkRequest
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data: data)
                    completionHandler(Result.success(json))
                case .failure(let error):
                    completionHandler(Result.failure(error))
                }
        }
    }
}
