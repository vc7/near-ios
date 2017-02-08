//
//  NRNTemperature.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNTemperature {
    var current: String?
    var high: String?
    var low: String?
}

extension NRNTemperature: LHNJSONDecodable {
    init?(json: JSON) {
        self.current = json["current"].string
        self.high = json["high"].string
        self.low = json["low"].string
    }
}
