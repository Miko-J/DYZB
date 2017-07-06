//
//  CycleModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/3.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    //主播对应的字典
    var room : [String : NSObject]? {
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    //主播模型对象
    var anchor : AnchorModel?
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
