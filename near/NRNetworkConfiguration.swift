//
//  NRNetworkConfiguration.swift
//  near
//
//  Created by vincent on 2017/02/05.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase

struct NRNetworkConfiguration: LHNetworkConfigurationType {
    var baseUrl: String
    
    init(url: String) {
        self.baseUrl = url
    }
    
    static let `default`: NRNetworkConfiguration = {
        var url = "https://nearapi.herokuapp.com/api/v1/"
        
        let configuration = NRNetworkConfiguration(url: url)
        return configuration
    }()
}
