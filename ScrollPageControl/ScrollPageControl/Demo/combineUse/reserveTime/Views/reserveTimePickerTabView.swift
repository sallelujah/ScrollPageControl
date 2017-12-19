//
//  reserveTimePickerTabView.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import UIKit
public enum mealTimeBtnType: Int {
    case breakFirst = 0
    case launch = 1
    case dinner = 2
    var btnTitle: String {
        switch self {
        case .breakFirst:
            return "早餐"
        case .launch:
            return "午餐"
        case .dinner:
            return "晚餐"
        }
    }
    var btnNormalImgName: String {
        switch self {
        case .breakFirst:
            return "breakFirst_btn_normal"
        case .launch:
            return "launch_btn_normal"
        case .dinner:
            return "dinner_btn_normal"
        }
    }
    var btnSelectedImgName: String {
        switch self {
        case .breakFirst:
            return "breakFirst_btn_selected"
        case .launch:
            return "launch_btn_selected"
        case .dinner:
            return "dinner_btn_selected"
        }
    }
}

class ReserveTimePickerTabView: UIView {
    
    fileprivate let itemH: CGFloat = 45
    fileprivate let buttonTag = 0725
    
    fileprivate var dataSource: [mealTimeBtnType] = [mealTimeBtnType]()
    
    typealias btnClickCallback = ((_ index: Int)->Void)
    var btnAction: btnClickCallback?
    
    convenience init(with timeArr: [mealTimeBtnType]) {
        self.init(frame: CGRect.zero)
        //        HPrint("dataSource:\(dataSource)")
        //        btnAction = btnTapAction
        dataSource = timeArr
        setupUI()
    }
    
    //MARK:- configUI
    fileprivate func setupUI() {
        addBtns()
    }
    
    fileprivate func addBtns() {
        let btnW = screenW/CGFloat(dataSource.count)
        
        dataSource.enumerated().forEach { (item: (offset: Int, element: mealTimeBtnType)) in
            let btnLeft = CGFloat(item.offset) * btnW
            let btn = UIButton(type: UIButtonType.custom)
            btn.setTitleColor(UIColor.unityTextColor(), for: UIControlState.normal)
            btn.setTitleColor(UIColor.unityRedColor(), for: UIControlState.selected)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            btn.set(image: UIImage(named: item.element.btnNormalImgName), title: item.element.btnTitle, titlePosition: .right, additionalSpacing: 17, state: .normal)
            btn.set(image: UIImage(named: item.element.btnSelectedImgName), title: item.element.btnTitle, titlePosition: .right, additionalSpacing: 17, state: .selected)
            
            btn.tag = buttonTag + item.element.rawValue
            btn.addTarget(self, action: #selector(btnClickedAction(btn:)), for: UIControlEvents.touchUpInside)
            self.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.left.equalTo(btnLeft)
                make.width.equalTo(btnW)
                make.height.equalToSuperview()
            })
            if item.offset == 0 {
                btn.isSelected = true
            }else {
                btn.addLine(frame: CGRect(x: 0, y: 10, width: 1, height: itemH - 20), color: UIColor.unitySeperatorLineColor())
            }
            
        }
        
    }
    //MARK:- Actions -if needed
    
    @objc fileprivate func btnClickedAction(btn: UIButton) {
        handleBtnState(by: btn.tag)
    }
    
    fileprivate func handleBtnState(by btnTag: Int) {
        self.subviews.forEach { (view) in
            if let btn = view as? UIButton {
                if btn.tag == btnTag {
                    if let completion = btnAction, !btn.isSelected{
                        completion(btn.tag - buttonTag)
                    }
                    btn.isSelected = true
                }else {
                    btn.isSelected = false
                }
            }
        }
    }
    
    
    
    //MARK:- Delegate -if needed
    
    
    
}


