//
//  CollectionHeadView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class CollectionHeadView: UICollectionReusableView {
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var iconImageVeiw: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    //定义模型属性
    var group : AnchorGroup? {
        didSet{
            titleLable.text = group?.tag_name
            iconImageVeiw.image = UIImage(named: group?.icon_name ?? "home_header_normal") //??代表前面有没有值
        }
    }
}
