//
//  BaseNavigationVC.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import UIKit

class BaseNavigationVC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.unityBlackColor()
        UINavigationBar.appearance().isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19),NSAttributedStringKey.foregroundColor: UIColor.unityBlackColor()]
        
        if #available(iOS 11.0, *) {
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for:UIBarMetrics.default)
        } else {
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        }
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !viewControllers.isEmpty{
            viewController.hidesBottomBarWhenPushed = true
            UIApplication.shared.keyWindow?.endEditing(true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
}

