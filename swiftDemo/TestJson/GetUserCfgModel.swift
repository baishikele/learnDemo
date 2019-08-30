//
//  GetUserCfgModel.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/30.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import HandyJSON


class Video_cfg    :  HandyJSON {
    var video_min_second: Int = 0
    var video_max_second: Int = 0
    var publish_auth: Int = 0
    required init() {}

}

class LiveUgc    :  HandyJSON {
    var status: String!
    var switchStatus: String!
    required init() {}

}

class UserLiveInfo    :  HandyJSON {
    var adStatus: Int = 0
    required init() {}

}

class VideoInfoSwitch    :  HandyJSON {
    var allowToLive: String!
    var allowedFormat: String!
    var bitrate: String!
    var framerate: String!
    var iframe: String!
    var isCompress: String!
    var maxResolution: String!
    var maxSecond: String!
    var maxSize: String!
    var message: String!
    var minSecond: String!
    required init() {}

}

class Promo    : HandyJSON {
    var icon_switch: String!
    var h5_url: String!
    var recharge_list_url: String!
    var un_live_pop: String!
    var live_pop: String!
    required init() {}

}

class Property_right    :  HandyJSON {
    var property_switch: Int = 0
    var show_type: Int = 0
    var title: String!
    var content: String!
    required init() {}

}

class Live_cfg    :  HandyJSON {
    var agreementUrl: String!
    var title: String!
    var default_city: String!
    required init() {}

}

class ModelData    : HandyJSON {
    required init() {}
    var video_cfg : Video_cfg?
    var live_cfg : Live_cfg?
    
}

class GetUserCfgModel    :  HandyJSON {
    var code: String!
    var action: String!
    var message: String!
    var data: ModelData!

    required init() {}
}
