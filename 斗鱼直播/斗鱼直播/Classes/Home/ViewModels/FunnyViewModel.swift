//
//  FunnyViewModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/10/2.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class FunnyViewModel:BaseAnchorViewModel{
    func loadFunnyData(finishedCallBack : @escaping()->()){
        loadAnchorData(isGroupData:false,URLString: "https://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
}
