//
//  AmuseViewModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/10.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
import Alamofire
class AmuseViewModel {
    lazy var amuseData : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel{
    func loadAmuseData(finishedCallBack: @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: "https://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            //将结果进行处理
            guard let resultDic = result as? [String : Any] else {return}
            guard let resultArr = resultDic["data"] as? [[String : Any]] else {return}
            
            //字典转模型
            for dic in resultArr {
                self.amuseData.append(AnchorGroup(dict: dic))
            }

            //回调
            finishedCallBack()
        }
    }
}
