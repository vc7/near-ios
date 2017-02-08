//
//  NRNPhoto.swift
//  near
//
//  Created by vincent on 2017/02/06.
//  Copyright © 2017年 vc7. All rights reserved.
//

import LHNetworkBase
import SwiftyJSON

struct NRNPhoto {
    var id: String?
    var owner: String?
    var title: String?
    var media: NRNMedia?
}

extension NRNPhoto: LHNJSONDecodable {
    init?(json: JSON) {
        self.id = json["id"].string
        self.owner = json["owner"].string
        self.title = json["title"].string
        self.media = NRNMedia(json: json["medias"])
    }
}
