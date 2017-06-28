//
//  PageContentView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/27.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(progress:CGFloat, sourceIndex: Int, targetIndex: Int)
}

fileprivate var contentCellID = "contentCellID"

class PageContentView: UIView {

    fileprivate var isForbidenScrollDelegate : Bool = false
    //初始偏移量
    fileprivate var startOffsetX: CGFloat = 0
    //设置代理
    weak var delegate : PageContentViewDelegate?
    //mark: -懒加载collection
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!//强制解包
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册collectionviewcell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    fileprivate var childVCS : [UIViewController]
    fileprivate weak var parentVC : UIViewController?
    init(frame: CGRect, childVCS: [UIViewController], parentVC:UIViewController?) {
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
            parentVC?.addChildViewController(childVC)
        }
        //添加collectionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//mark: -UICollectionViewDataSource
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
//mark: -UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isForbidenScrollDelegate = false
         startOffsetX = collectionView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidenScrollDelegate {return}
        //当前偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let scrollViewW = collectionView.frame.size.width
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        var progress : CGFloat = 0
        if currentOffsetX > startOffsetX{//往左滑动
            progress = CGFloat(currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            //防止越界
            if targetIndex >= childVCS.count {
                targetIndex = childVCS.count - 1
            }
            //完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1;
                targetIndex = sourceIndex
            }
        }else{//往右滑
            progress = 1 - CGFloat((currentOffsetX/scrollViewW) - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            //防止越界
            if sourceIndex >= childVCS.count {
                sourceIndex = childVCS.count - 1
            }
        }
        //通知代理
        delegate?.pageContentView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
//mark: -对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        isForbidenScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
