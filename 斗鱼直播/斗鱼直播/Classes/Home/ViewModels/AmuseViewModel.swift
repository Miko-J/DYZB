//
//  AmuseViewModel.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/10.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
import Alamofire
class AmuseViewModel: BaseAnchorViewModel{
    
}

extension AmuseViewModel{
    func loadAmuseData(finishedCallBack: @escaping () -> ()){
        
        loadAnchorData(isGroupData:true,  URLString: "https://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack)

    }
}
