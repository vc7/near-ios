//
//  NRNMedia.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNMedia {
    var mediumUrlString: String?
    var largeUrlString:String?
}

extension NRNMedia: LHNJSONDecodable {
    init?(json: JSON) {
        self.mediumUrlString = json["medium"].string
        self.largeUrlString = json["large"].string
    }
}
