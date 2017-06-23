//
//  MainTarBarViewController.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/23.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

class MainTarBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addChildVC(storyBoardName: "Home")
//        addChildVC(storyBoardName: "Live")
//        addChildVC(storyBoardName: "Follow")
//        addChildVC(storyBoardName: "Profile")

    }
    
    private func addChildVC(storyBoardName : String){
        
        let childVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
    }

}
