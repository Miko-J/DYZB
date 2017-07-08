//
//  BaseGameModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/8.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    //定义属性
    //组中的标题
    var tag_name : String = ""
    //游戏对应的图标
    var icon_url : String = ""
    //自定义构造函数
    override init() {
    }
    init(dict : [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
