//
//  KCollectionPrettyCell.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
import Kingfisher
class KCollectionPrettyCell: CollectionBaseCell {
    

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {//override重写父类
        didSet{
            //将属性传给父类
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
