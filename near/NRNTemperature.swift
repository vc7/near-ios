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
    var current: Float?
    var high: Float?
    var low: Float?
}

extension NRNTemperature: LHNJSONDecodable {
    init?(json: JSON) {
        self.current = json["current"].float
        self.high = json["high"].float
        self.low = json["low"].float
    }
}
