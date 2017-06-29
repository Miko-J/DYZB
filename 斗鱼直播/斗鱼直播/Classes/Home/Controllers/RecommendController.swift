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
fileprivate let KitemH = KitemW * 3 / 4
fileprivate let KnormalCellID = "KnormalCellID"
fileprivate let KHeadCellID = "KHeadCellID"
fileprivate let KHeadH : CGFloat = 50
class RecommendController: UIViewController {
    
    //mark： -懒加载collection
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        //print("%d","%d","%d",KscreenWidth,KitemW,KitemH)
        layout.itemSize = CGSize(width: KitemW, height: KitemH)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = KitemMargin
        layout.headerReferenceSize = CGSize(width: KscreenWidth, height: KHeadH)
        layout.sectionInset = UIEdgeInsetsMake(0, KitemMargin, 0, KitemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        //随着父控件的变化而变化
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "KCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KnormalCellID)
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
    }
}
//mark: -设置UI
extension RecommendController {
    fileprivate func setUpUI() {
        view.addSubview(collectionView)
    }
}
//mark: -遵守
extension RecommendController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KnormalCellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadCellID, for: indexPath)
        return headView
    }
}


