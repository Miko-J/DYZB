//
//  BaseAnchorController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/11.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KitemMargin : CGFloat = 10
let KitemW = (KscreenWidth - KitemMargin * 3) / 2
let KitemNormalH = KitemW * 3 / 4
let KitemPrettyH = KitemW * 4 / 3
fileprivate let KHeadH : CGFloat = 50

fileprivate let KnormalCellID = "KnormalCellID"
let KPrettyCellID = "KPrettyCellID"
fileprivate let KHeadCellID = "KHeadCellID"


class BaseAnchorController: BaseViewController {
    
    //获取数据模型
    lazy var baseVM : BaseAnchorViewModel = BaseAnchorViewModel()
    //mark： -懒加载collection
    lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        loadData()
    }
    
}

//mark: -设置ui
extension BaseAnchorController{
    override func setUpUI(){
        //给contentView赋值
        contentView = contentView
        //添加collectionView
        view.addSubview(collectionView)
        //调用super
        super.setUpUI()
    }
}

//mark: -加载数据
extension BaseAnchorController{
    func loadData(){
    }
}

//mark: -遵守UICollectionViewDataSource
extension BaseAnchorController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorsGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorsGroup[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KnormalCellID, for: indexPath) as! KCollectionNormalCell
        
        cell.anchor = baseVM.anchorsGroup[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadCellID, for: indexPath) as! CollectionHeadView
        headView.group = baseVM.anchorsGroup[indexPath.section]
        return headView
    }
    
}

