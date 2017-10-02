//
//  AmuseController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/10.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KmenuViewH : CGFloat = 200

class AmuseController: BaseAnchorController {
    //mark: -模型数据
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    //mark: -懒加载
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMendView()
        menuView.frame = CGRect(x: 0, y: -KmenuViewH, width: KscreenWidth, height: KmenuViewH)
        return menuView
    }()
}
//设置ui
extension AmuseController{
    override func setUpUI() {
        //调用父类
        super.setUpUI()
        //添加menuview
        collectionView.addSubview(amuseMenuView)
        //设置内边距
        collectionView.contentInset = UIEdgeInsetsMake(KmenuViewH, 0, 0, 0)
    }
}
//mark: -加载数据
extension AmuseController{
    override func loadData(){
        //传递模型数据
        baseVM = amuseVM
        amuseVM.loadAmuseData{
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorsGroup
            tempGroups.removeFirst()
            //传递数据
            self.amuseMenuView.anchorGroup = tempGroups;
            
            //加载数据完成
            self.loadDataFinished()
        }
    }
}
