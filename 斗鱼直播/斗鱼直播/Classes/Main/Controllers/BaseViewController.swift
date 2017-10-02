//
//  BaseViewController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/10/2.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK:定义属性
    var contentView : UIView?
    //MARK:懒加载
    fileprivate lazy var imageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named:"img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    //MARK:系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

extension BaseViewController{
    func setUpUI() {
        //设置contentView隐藏
        contentView?.isHidden = true
        //添加imageView
        view.addSubview(imageView)
        //开始动画
        imageView.startAnimating()
        //设置背景色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        imageView.startAnimating()
        imageView.isHidden = true
        contentView?.isHidden = false
    }
}

