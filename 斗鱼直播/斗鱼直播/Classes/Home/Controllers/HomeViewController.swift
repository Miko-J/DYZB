//
//  HomeViewController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/23.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let titleViewH : CGFloat = 40
class HomeViewController: UIViewController {
    //mark：-懒加载titleView
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y:statusBarH + NavigationBarH , width: KscreenWidth, height: titleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    //mark：-懒加载contentView
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        let tempH = statusBarH + NavigationBarH + titleViewH
        let contentViewH = KscreenHeight - tempH
        let contentFrame = CGRect(x: 0, y: tempH, width: KscreenWidth, height: contentViewH)
        var childVCs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVCS: childVCs, parentVC:self)
        contentView.delegate = self
        return contentView
    }()
    //mark: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //不需要调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置UI
        setUpUI()
        //添加titleView
        view.addSubview(pageTitleView)
        //添加contentView
        view.addSubview(pageContentView)
    }

}

//mark: -遵循PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selecIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//mark: -遵循
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
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
