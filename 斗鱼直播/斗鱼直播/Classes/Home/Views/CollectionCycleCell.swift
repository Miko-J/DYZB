//
//  CollectionCycleCell.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/6.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    //mark： -定义模型属性
    var cycleModel : CycleModel? {
        didSet{
            titleLable.text = cycleModel?.title
            let imageUrl = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: imageUrl)
        }
    }

}
