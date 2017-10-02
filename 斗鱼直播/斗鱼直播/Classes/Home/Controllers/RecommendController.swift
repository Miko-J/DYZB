//
//  RecommendController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit


fileprivate let KcycleViewH = KscreenWidth * 3 / 8
fileprivate let KGameViewH : CGFloat = 90

class RecommendController: BaseAnchorController {
    
    //mark: -recommendCycleView
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
        let cycle = RecommendCycleView.recommendCycleView()
        cycle.frame = CGRect(x: 0, y: -(KcycleViewH + KGameViewH), width: KscreenWidth, height: KcycleViewH)
        return cycle
    }()
    
    //mark: -KGameView
    fileprivate lazy var kGameView : KGameView = {
        let gameView = KGameView.kGameView()
        gameView.frame = CGRect(x: 0, y: -KGameViewH, width: KscreenWidth, height: KGameViewH)
        return gameView
    }()
    
    //mark：-viewModel
    fileprivate lazy var recommendVM : RcommendViewModel = RcommendViewModel()
}
//mark: -设置UI
extension RecommendController {
    override func setUpUI() {
        super.setUpUI()//创建collection
        //添加recommendCycleView
        collectionView.addSubview(recommendCycleView)
        
        //添加kgameView
        collectionView.addSubview(kGameView)
        //设置内边距
        collectionView.contentInset = UIEdgeInsetsMake(KcycleViewH+KGameViewH, 0, 0, 0)
    }
}
//mark: -发送网络请求
extension RecommendController {
    override func loadData() {
        //传递模型数据
        baseVM = recommendVM;
        //获取推荐网络请求数据
        recommendVM.requesetData {
            self.collectionView.reloadData()
            
            //给gameview传递数据
            var gameGroup = self.recommendVM.anchorsGroup
            //移除前两组数据
            gameGroup.remove(at: 0)
            gameGroup.remove(at: 0)
            
            //添加更多的数据
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            gameGroup.append(moreGroup)
            
            self.kGameView.gameGroup = gameGroup
            
            //加载数据完成
            self.loadDataFinished()
        }
        //获取轮播图的请求数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModel
        }
        
    }
}
//mark: -遵守UICollectionViewDataSource
extension RecommendController{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! KCollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorsGroup[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: KitemW, height: KitemPrettyH)
        }
        return CGSize(width: KitemW, height: KitemNormalH)
    }
}


