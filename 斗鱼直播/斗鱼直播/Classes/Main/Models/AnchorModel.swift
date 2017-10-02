//
//  AnchorModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/30.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    /// 房间ID
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    //某些键没有用到的情况下重写
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
