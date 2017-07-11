//
//  AmuseController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/10.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class AmuseController: BaseAnchorController {
    //mark: -模型数据
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}
//mark: -加载数据
extension AmuseController{
    override func loadData(){
        //传递模型数据
        baseVM = amuseVM
        amuseVM.loadAmuseData{
            self.collectionView.reloadData()
        }
    }
}
