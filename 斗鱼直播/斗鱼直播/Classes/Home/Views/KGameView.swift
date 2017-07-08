//
//  KGameView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/6.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KGameID = "KGameID"
fileprivate let KEdgeMargin : CGFloat = 10
class KGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //定义模型属性
    var gameGroup : [AnchorGroup]?{
        didSet{
            //移除前两组数据
            gameGroup?.remove(at: 0)
            gameGroup?.remove(at: 0)
            
            //添加更多的数据
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            gameGroup?.append(moreGroup)
            
            //刷新数据
            collectionView.reloadData()
        }
    }
    
    //系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //子控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameID)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, KEdgeMargin, 0, KEdgeMargin)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.showsHorizontalScrollIndicator = false
    }

}
//快速创建类方法
extension KGameView {
    class func kGameView() -> KGameView {
        return Bundle.main.loadNibNamed("KGameView", owner: nil, options: nil)?.first as! KGameView
    }
}

extension KGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameGroup?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameGroup?[indexPath.item]
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
}
