//
//  RcommendViewModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class RcommendViewModel {
    //mark: -主播模型数组
    lazy var anchorsGroup : [AnchorGroup] = [AnchorGroup]()
    
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    //颜值
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RcommendViewModel {
    func requesetData(finishCallBack:@escaping () ->()){
        
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //2.创建组
        let dGroup = DispatchGroup()
        
        //1.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            //1.将result转成字典模型
            guard let resultDic = result as? [String : NSObject] else {return}
            //2.根据key获取字典数组
            guard let resultArr = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //3.设值
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //4.字典转模型
            for dic in resultArr {
                let anchors = AnchorModel(dict: dic)
                self.bigDataGroup.anchors.append(anchors)
            }
            //5.离开组
            dGroup.leave()
        }
        
        //2.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //1.将result转成字典模型
           guard let resultDic = result as? [String : NSObject] else {return}
            //2.根据key获取字典数组
            guard let resultArr = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //3.设值
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //4.字典转模型
            for dic in resultArr {
                let anchors = AnchorModel(dict: dic)
                self.prettyGroup.anchors.append(anchors)
            }
            //5.离开组
            dGroup.leave()
            
        }
        
        //3.请求第三部分游戏数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            
            //2.根据key获取字典数组
            guard let anchorArr = resultDic["data"] as? [[String : NSObject]] else {return}
            //3.遍历字典转成模型
            for dic in anchorArr{
                let group = AnchorGroup(dict: dic)
                self.anchorsGroup.append(group)
            }
//            for group in self.anchorsGroup {
//                for anchors in group.anchors{
//                    print(anchors.nickname)
//                }
//            }
//          //4.离开组
            dGroup.leave()
        }
        //5.将所有的数据请求之后排序
        dGroup.notify(queue: DispatchQueue.main){//闭包用self
            self.anchorsGroup.insert(self.prettyGroup, at: 0)
            self.anchorsGroup.insert(self.bigDataGroup, at: 0)
            //成功的回调
            finishCallBack()
        }
       // print(self.anchorsGroup)
    }
}
