//
//  AnchorGroup.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/30.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    ///该组中对应的房间信息
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict : dict))
            }
        }
    }
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    ///组中的标题
    var tag_name: String = ""
    ///组显示的图标
    var icon_name: String = "home_header_normal"
    ///游戏对应的图标
    var icon_url: String = ""
    ///构造函数
    override init() {
    }
    init(dict: [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    /*
     override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list"{
            if let dataArray = value as? [[String: NSObject]]{
                for dict in dataArray {
                    anchors.append(AnchorModel(dict:dict))
                }
            }
        }
     }
     */

}
