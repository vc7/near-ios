//
//  NRNLocation.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNLocation {
    var city: NRNCity?
    var temperature: NRNTemperature?
    var nearByStations: [String]?
}

extension NRNLocation: LHNJSONDecodable {
    init?(json: JSON) {
        self.city = NRNCity(json: json["city"])
        self.temperature = NRNTemperature(json: json["temperature"])
        self.nearByStations = json["nearby_stations"].array?.filter({ $0.string != nil }).map({ $0.string! })
    }
}
