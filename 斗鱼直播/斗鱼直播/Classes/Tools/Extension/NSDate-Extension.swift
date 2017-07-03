//
//  NSDate-Extension.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/30.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return ("\(interval)")
    }
}
