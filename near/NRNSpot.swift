//
//  NRNSpot.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNSpot {
    var id: String?
    var name: String?
    var categoryIconUrlString: String?
    var hereCount: Int
    var access: NRNAccess?
}

extension NRNSpot: LHNJSONDecodable {
    init?(json: JSON) {
        self.id = json["id"].string
        self.name = json["name"].string
        self.categoryIconUrlString = json["category_icon"].string
        self.hereCount = json["here_count"].intValue
        self.access = NRNAccess(json: json["access"])
    }
}

