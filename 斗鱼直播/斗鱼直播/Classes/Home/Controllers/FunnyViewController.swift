//
//  FunnyViewController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/10/2.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
fileprivate let KTopMargin:CGFloat = 8
class FunnyViewController: BaseAnchorController {
    //懒加载viewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController{
    override func setUpUI() {//override重写父类方法
        super.setUpUI();
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsetsMake(KTopMargin, 0, 0, 0)
    }
}

extension FunnyViewController{
    override func loadData() {
        //给baseVM赋值
        baseVM = funnyVM
        //请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
}
