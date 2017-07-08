//
//  GameController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/8.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KEdgeMargin : CGFloat = 10
fileprivate let KitemW = (KscreenWidth - KEdgeMargin * 2) / 3
fileprivate let KitemH = KitemW * 6 / 5
fileprivate let KHeadH : CGFloat = 50
fileprivate let KGameCellID = "KGameCellID"
fileprivate let KGameHeadViewID = "KGameHeadViewID"
class GameController: UIViewController {

    //mark: -懒加载
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KitemW, height: KitemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        //设置头部
        layout.headerReferenceSize = CGSize(width: KscreenWidth, height: KHeadH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, KEdgeMargin, 0, KEdgeMargin)
        collectionView.backgroundColor = UIColor.white
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        //注册头部
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KGameHeadViewID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        collectionView.dataSource = self
        return collectionView
    }()
    //mark: -系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui
        setUpUI()
        //网络请求
        loadRequest()
    }
}

//mark: -设置ui
extension GameController{
    fileprivate func setUpUI(){
        view.addSubview(collectionView)
    }
}

//mark: -网络请求
extension GameController{
    fileprivate func loadRequest(){
       self.gameVM.loadRequest {
            //刷新数据
            self.collectionView.reloadData()
        }
    }
}

//mark: -遵守UICollectionViewDataSource协议
extension GameController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.gameModels[indexPath.item]
        //cell.backgroundColor = UIColor.andomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KGameHeadViewID, for: indexPath) as! CollectionHeadView
        headView.titleLable.text = "全部"
        headView.moreBtn.isHidden = true
        headView.iconImageVeiw.image = UIImage(named: "Img_orange")
        return headView
    }
}
