//
//  NRNCity.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNCity {
    var name: String?
    var prefecture: String?
    var postal: String?
}

extension NRNCity: LHNJSONDecodable {
    init?(json: JSON) {
        self.name = json["name"].string
        self.prefecture = json["prefecture"].string
        self.postal = json["postal"].string
    }
}
