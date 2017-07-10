//
//  RecommendController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KitemMargin : CGFloat = 10
fileprivate let KitemW = (KscreenWidth - KitemMargin * 3) / 2
fileprivate let KitemNormalH = KitemW * 3 / 4
fileprivate let KitemPrettyH = KitemW * 4 / 3

fileprivate let KcycleViewH = KscreenWidth * 3 / 8
fileprivate let KGameViewH : CGFloat = 90
fileprivate let KnormalCellID = "KnormalCellID"
fileprivate let KPrettyCellID = "KPrettyCellID"
fileprivate let KHeadCellID = "KHeadCellID"
fileprivate let KHeadH : CGFloat = 50
class RecommendController: UIViewController {
    
    
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
    
    //mark： -懒加载collection
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        //print("%d","%d","%d",KscreenWidth,KitemW,KitemH)
        layout.itemSize = CGSize(width: KitemW, height: KitemNormalH)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = KitemMargin
        layout.headerReferenceSize = CGSize(width: KscreenWidth, height: KHeadH)
        layout.sectionInset = UIEdgeInsetsMake(0, KitemMargin, 0, KitemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        //随着父控件的变化而变化
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "KCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KnormalCellID)
        collectionView.register(UINib(nibName: "KCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellID)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KnormalCellID)
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeadCellID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeadCellID)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui
        setUpUI()

        //发送网络请求
        loadRequest()
    }
}
//mark: -设置UI
extension RecommendController {
    fileprivate func setUpUI() {
        view.addSubview(collectionView)
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
    fileprivate func loadRequest() {
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
        }
        //获取轮播图的请求数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModel
        }
    }
}
//mark: -遵守UICollectionViewDataSource
extension RecommendController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorsGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorsGroup[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //获取模型数据
        let group = recommendVM.anchorsGroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! KCollectionPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KnormalCellID, for: indexPath) as! KCollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadCellID, for: indexPath) as! CollectionHeadView
        let group = recommendVM.anchorsGroup[indexPath.section]
        headView.group = group
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: KitemW, height: KitemPrettyH)
        }
        return CGSize(width: KitemW, height: KitemNormalH)
    }
}


