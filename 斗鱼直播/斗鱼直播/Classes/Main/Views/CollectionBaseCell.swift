//
//  CollectionBaseCell.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/3.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var nickNameLable: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchor : AnchorModel? {
        didSet{
            
            guard let anchor = anchor else {return}
            
            nickNameLable.text = anchor.nickname
            
            //显示在线人数
            var onLineStr : String = ""
            
            if anchor.online >= 10000 {
                onLineStr = ("\(anchor.online / 10000)万在线")
            }else{
                onLineStr = ("\(anchor.online)在线")
            }
            onLineBtn.setTitle(onLineStr, for: .normal)
            
            
            guard let imageUrl = URL(string: anchor.vertical_src) else {return}
            
            iconImageView.kf.setImage(with: imageUrl)
        }
    }
    
   
}
