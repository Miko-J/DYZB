//
//  HomeViewController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/23.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }

}

//mark: -设置UI界面
extension HomeViewController{
    
    fileprivate func setUpUI(){
        //设置导航栏
        setUpNavigartionBar()
    }
    
    fileprivate func setUpNavigartionBar(){
        
        //左侧item
        /*
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        let leftItem = UIBarButtonItem.init(customView: btn)
         */
        let leftItem = UIBarButtonItem(imageName: "logo", higImageName: "", size: .zero)
        navigationItem.leftBarButtonItem = leftItem
        
        /* 初级写法
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named:"image_my_history"), for: .normal)
        historyBtn.setImage(UIImage(named:"Image_my_history_click"), for: .highlighted)
        
        historyBtn.frame = CGRect(origin: .zero, size: btnSize)
        let historyItem = UIBarButtonItem.init(customView: historyBtn)
        navigationItem.rightBarButtonItems = [historyItem]
         */
        
        /* 类封装
        let historyItem = UIBarButtonItem.creatItem(imageName:"image_my_history", higImageName:"Image_my_history_click", size:btnSize)
        */
        let btnSize = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", higImageName: "Image_my_history_click", size: btnSize)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", higImageName: "btn_search_clicked", size: btnSize)
        
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", higImageName: "Image_scan_click", size: btnSize)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrCodeItem]
    }
}
