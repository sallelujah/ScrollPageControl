//
//  BaseTabBarVC.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import UIKit

class BaseTabBarVC: UITabBarController {
    
    fileprivate lazy var HomePageNVC: BaseNavigationVC = {
        //HomePageController
        let NVC = BaseNavigationVC(rootViewController: NormalDemoVC())
        NVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)
//        NVC.tabBarItem = UITabBarItem(title: "NormalDemo", image: UIImage.init(named: "home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "home_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        return NVC
    }()
    fileprivate lazy var orderManagementNVC: BaseNavigationVC = {
        let NVC = BaseNavigationVC(rootViewController: TimeSelectDemoVC())
        NVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 0)
//        NVC.tabBarItem = UITabBarItem(title: "组合", image: UIImage.init(named: "order")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "order_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
//        NVC.navigationItem.title = "订单"
        return NVC
    }()
    fileprivate lazy var MyZoneNVC: BaseNavigationVC = {
        let NVC = BaseNavigationVC(rootViewController: ViewController())
        NVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.more, tag: 0)
//        NVC.tabBarItem = UITabBarItem(title: "我的", image: UIImage.init(named: "mine")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "mine_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
//        NVC.navigationItem.title = "我的"
        return NVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [HomePageNVC,orderManagementNVC,MyZoneNVC]
        self.tabBar.tintColor = UIColor.unityRedColor()
        self.tabBar.backgroundColor = UIColor.white
    }
    
}

