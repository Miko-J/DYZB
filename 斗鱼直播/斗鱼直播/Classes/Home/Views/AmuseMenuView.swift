//
//  AmuseMenuView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/11.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate  let collectionAmuseMenuCell = "collectionAmuseMenuCell"

class AmuseMenuView: UIView {
    
    var anchorGroup : [AnchorGroup]? {
        didSet{
            //刷新数据
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    //系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        //不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionAmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: collectionAmuseMenuCell)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
}
//快速创建的类方法
extension AmuseMenuView{
    class func amuseMendView() ->AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if anchorGroup == nil{ return 0 }
        let pageNum =  (anchorGroup!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionAmuseMenuCell, for: indexPath) as! CollectionAmuseMenuCell
        //cell.backgroundColor = UIColor.andomColor()
        setCellWithData(cell :cell, indexPath : indexPath)
        return cell
    }
    
    fileprivate func setCellWithData(cell : CollectionAmuseMenuCell, indexPath: IndexPath){
        //传入的数据
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //越界处理
        if endIndex > anchorGroup!.count - 1 {
            endIndex = anchorGroup!.count - 1
        }
        cell.anchorGroup = Array(anchorGroup![startIndex...endIndex])
    }
}

extension AmuseMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = (Int)(collectionView.contentOffset.x / collectionView.bounds.size.width)
    }
}
