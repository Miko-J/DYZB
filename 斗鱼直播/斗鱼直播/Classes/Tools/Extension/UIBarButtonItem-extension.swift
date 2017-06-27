//
//  UIBarButtonItem-extension.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/23.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /*类封装
    class func creatItem(imageName:String, higImageName:String, size:CGSize) -> UIBarButtonItem {
        //创建btn
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:higImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem.init(customView: btn)
    }
 */
    
    //便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName:String, higImageName:String = "", size:CGSize = .zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if higImageName != "" {
            btn.setImage(UIImage(named:higImageName), for: .highlighted)
        }
        if size == .zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: .zero, size: size)
        }
        self.init(customView: btn)
    }
}
