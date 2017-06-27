//
//  PageContentView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/27.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate var contentCellID = "contentCellID"

class PageContentView: UIView {

    //mark: -懒加载collection
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        
        //注册collectionviewcell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    fileprivate var childVCS : [UIViewController]
    fileprivate var parentVC : UIViewController
    init(frame: CGRect, childVCS: [UIViewController], parentVC:UIViewController) {
        self.childVCS = childVCS
        self.parentVC = parentVC
        super.init(frame: frame)
        //设置ui
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//mark: -设置ui
extension PageContentView {
    fileprivate func setUpUI() {
        //1.将所有的子控制器添加到父控制器中
        for childVC in childVCS {
            parentVC.addChildViewController(childVC)
        }
        //添加collectionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCS.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = childVCS[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}
