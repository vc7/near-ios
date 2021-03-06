//
//  NRNAccess.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNAccess {
    var latitude: Double?
    var longitude: Double?
    var distance: Float?
    var address: String?
}

extension NRNAccess: LHNJSONDecodable {
    init?(json: JSON) {
        self.latitude = json["latitude"].double
        self.longitude = json["longitude"].double
        self.distance = json["distance"].float
        self.address = json["address"].string
    }
}

