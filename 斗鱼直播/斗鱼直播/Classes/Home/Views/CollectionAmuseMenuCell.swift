//
//  CollectionAmuseMenuCell.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/11.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let collectionGameCell = "collectionGameCell"
class CollectionAmuseMenuCell: UICollectionViewCell {
    
    //模型数据
    var anchorGroup : [AnchorGroup]?{
        didSet{
            //刷新数据
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: collectionGameCell)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.size.width / 4
        let itemH = collectionView.bounds.size.height / 2
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
    

}
extension CollectionAmuseMenuCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroup?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionGameCell, for: indexPath) as! CollectionGameCell
        //cell.backgroundColor = UIColor.andomColor()
        cell.baseGame = anchorGroup?[indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
