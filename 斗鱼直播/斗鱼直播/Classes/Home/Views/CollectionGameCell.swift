//
//  CollectionGameCell.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/7.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
  
    //定义模型属性
    var baseGame : BaseGameModel? {
        didSet{
            titleLable.text = baseGame?.tag_name
            
            let imageUrl = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: imageUrl,placeholder:UIImage(named: "home_more_btn"))
        }
    }
    

}
