//
//  BaseAnchorViewModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/11.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class BaseAnchorViewModel {
    lazy var anchorsGroup : [AnchorGroup] = [AnchorGroup]()
}


extension BaseAnchorViewModel{
    func loadAnchorData(isGroupData:Bool, URLString:String, parameters:[String : Any]? = nil,finishedCallBack:@escaping ()->()){
        NetworkTools.requestData(.get, URLString: URLString,parameters: parameters) { (result) in
            //将结果进行处理
            guard let resultDic = result as? [String : Any] else {return}
            guard let resultArr = resultDic["data"] as? [[String : Any]] else {return}
            
            
            if isGroupData{
                //字典转模型
                for dic in resultArr {
                    self.anchorsGroup.append(AnchorGroup(dict: dic))
                }
            }else{
                let group = AnchorGroup()
                for dic in resultArr{
                    group.anchors.append(AnchorModel(dict:dic))
                }
                self.anchorsGroup.append(group)
            }

            //回调
            finishedCallBack()
        }

    }
}
