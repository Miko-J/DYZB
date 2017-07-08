//
//  GameViewModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/8.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
import Alamofire


class GameViewModel {
    //mark： -定义模型数组
    lazy var gameModels : [GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadRequest(finishCallBack: @escaping () -> ()){
        NetworkTools.requestData(.get, URLString: "https://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            //获取请求数据
            guard let dicData = result as? [String : Any] else {return}
            guard let dicArray = dicData["data"] as? [[String : Any]] else {return}
            //字典转模型
            for dic in dicArray {
                self.gameModels.append(GameModel(dict:dic))
            }
            //回调
            finishCallBack()
        }
    }
}
