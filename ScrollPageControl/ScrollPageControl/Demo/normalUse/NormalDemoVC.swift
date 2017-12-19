//
//  DemoVC.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import UIKit
class NormalDemoVC: UIViewController {
    
    // MARK: - lazy Views & other configuratios
    
    fileprivate let controllerViewH: CGFloat  = NavigationBarH + tabBarHeight + statusBarHeight ///(从navigationbar底部 + 滚动条  所有顶部的高度)
    
    fileprivate lazy var orderInserviceVC: ViewController = {
        let vc = ViewController()
        vc.view.backgroundColor = #colorLiteral(red: 0.1754975617, green: 0.1847661436, blue: 0.3257630467, alpha: 1)
        return vc
    }()
    
    fileprivate lazy var OrderCompleteVC: ViewController = {
        let vc = ViewController()
        vc.view.backgroundColor = #colorLiteral(red: 0.3388231397, green: 0.5773878098, blue: 0.7563222051, alpha: 1)
        return vc
    }()
    
    fileprivate lazy var wholeOrderVC: ViewController = {
        let vc = ViewController()
        vc.view.backgroundColor = #colorLiteral(red: 0.2087402344, green: 0.1820210814, blue: 0.0005342919612, alpha: 1)
        return vc
    }()
    
    fileprivate lazy var scrollSegmentStyle: SegmentStyle = {
        var style  = SegmentStyle()
        style.showLine = true
        style.scrollTitle  = false
        style.gradualChangeTitleColor = true
        style.scrollLineColor = UIColor.unityRedColor()
        style.scrollLineHeight = 2
        style.selectedTitleColor = UIColor(red: 255/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1.0)
        style.titleFont = UIFont.systemFont(ofSize: 15)
        style.SegmentHeight = 40
        style.hasVerticalSeperatorLine = true
        return style
    }()
    fileprivate lazy var childVCs: [UIViewController] = {
        
        return [self.orderInserviceVC, self.OrderCompleteVC, self.wholeOrderVC]
    }()
    
    fileprivate lazy var childVCTitles: [String] = {
        return ["进行中", "已完成", "全部"]
    }()
    
    fileprivate lazy var scrollPageControl: ScrollPageView = {
//        var scrollFrame = self.view.frame
//        scrollFrame.origin.y += NavigationBarH + statusBarHeight
        let scroll: ScrollPageView = ScrollPageView(frame: self.view.frame, segmentStyle: self.scrollSegmentStyle, titles: self.childVCTitles, childVcs: self.childVCs, parentViewController: self)
        scroll.addLine(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 0.5), color: UIColor(hexString: "e3e3e5"))
        return scroll
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.height -= self.controllerViewH
        configData()
        configUI()
        addObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension NormalDemoVC {
    
    // MARK: - addObserver
    fileprivate func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didScroll(noti:)), name: NSNotification.Name.ScrollPageViewDidShowThePageNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToIndex(noti:)), name: NSNotification.Name.ScrollPageViewShouldShowThePageNotification, object: nil)

    }
    
    @objc fileprivate func didScroll(noti: NSNotification) {
        if let parentVCStr: String = noti.userInfo!["parentVC"] as! String? , parentVCStr == StringFromClass(self) as String{
            HPrint("noti.userInfo:\(noti.userInfo!)",noti.userInfo!["currentIndex"] ?? " acceptted nil info notification！")
            if let index: Int = noti.userInfo!["currentIndex"] as! Int? {
                refreshData(at: index)
            }
        }
    }
    @objc fileprivate func scrollToIndex(noti: NSNotification) {
        if let parentVCStr: String = noti.userInfo!["parentVC"] as! String? , parentVCStr == StringFromClass(self) as String{
             HPrint("noti.userInfo:\(noti.userInfo!)",noti.userInfo!["currentIndex"] ?? " acceptted nil info notification！")
            if let index: Int = noti.userInfo!["currentIndex"] as! Int? {
                scrollPageControl.selectedIndex(selectedIndex: index, animated: true)
            }
        }
    }
    //MARK:- Actions
    
    //MARK:- configData
    
    fileprivate func refreshData(at index: Int) {
        switch index {
        case 0:
            self.orderInserviceVC.refreshData()
        case 1:
            self.OrderCompleteVC.refreshData()
        case 2:
            self.wholeOrderVC.refreshData()
        default:break
        }
    }
    
    fileprivate func configData() -> Void {
        refreshData(at: 0)
    }
    
    //MARK:- configUI
    
    fileprivate func configUI() {
        title = "首页"
        view.backgroundColor = UIColor.unityBackGroundColor()
        if #available(iOS 11.0, *) {
            scrollPageControl.contentView.collectionView.contentInsetAdjustmentBehavior = .never
        }else {
            self.automaticallyAdjustsScrollViewInsets = false
        }// 必要的设置
        view.addSubview(scrollPageControl)
    }
}


