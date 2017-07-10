//
//  AmuseController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/10.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KitemMargin : CGFloat = 10
fileprivate let KitemW = (KscreenWidth - KitemMargin * 3) / 2
fileprivate let KitemNormalH = KitemW * 3 / 4
fileprivate let KitemPrettyH = KitemW * 4 / 3
fileprivate let KHeadH : CGFloat = 50

fileprivate let KnormalCellID = "KnormalCellID"
fileprivate let KPrettyCellID = "KPrettyCellID"
fileprivate let KHeadCellID = "KHeadCellID"

class AmuseController: UIViewController {
    
    //mark: -模型数据
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
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
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeadCellID)
        collectionView.backgroundColor = UIColor.white
        return collectionView
        }()
    //系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        loadData()
    }
}
//mark: -设置ui
extension AmuseController{
    fileprivate func setUpUI(){
        view.addSubview(collectionView)
    }
}
//mark: -加载数据
extension AmuseController{
    fileprivate func loadData(){
        amuseVM.loadAmuseData{
            self.collectionView.reloadData()
        }
    }
}
//mark: -遵守UICollectionViewDataSource
extension AmuseController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.amuseData.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.amuseData[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KnormalCellID, for: indexPath) as! KCollectionNormalCell
        
        cell.anchor = amuseVM.amuseData[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadCellID, for: indexPath) as! CollectionHeadView
        headView.group = amuseVM.amuseData[indexPath.section]
        return headView
    }
    
}

