//
//  TimeSelectDemoVC.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import UIKit
typealias callBack = (()->Void)

class TimeSelectDemoVC: UIViewController {
    
    // MARK: - lazy Views & other configuratios
    fileprivate let bottomBtnH: CGFloat = 40
    
    fileprivate lazy var bottomBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("确定", for: .normal)
        btn.backgroundColor = UIColor.unityRedColor()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(bottomBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    
    fileprivate lazy var scrollSegmentStyle: SegmentStyle = {
        var style  = SegmentStyle()
        style.showLine = true
        style.scrollTitle  = true
        style.gradualChangeTitleColor = true
        style.scrollLineColor = UIColor.unityRedColor()
        style.titleMargin = 30
        //        style.selectedTitleColor = UIColor(red: 254/255.0, green: 116/255.0, blue: 83/255.0, alpha: 1.0)
        style.selectedTitleColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        style.normalTitleColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        style.scrollLineHeight = 1
        style.titleFont = UIFont.systemFont(ofSize: 14)
        style.SegmentHeight = 55
        return style
    }()
    
    fileprivate lazy var childVCs: [ReserveTimePickerDetailVC] = {
        var tempArr = [ReserveTimePickerDetailVC]()
        ReserveTimeStampManager.shared.vaildChildVcDataSource.forEach({ (item:(breakFirst: [String], launch: [String], dinner: [String])) in
            tempArr.append(ReserveTimePickerDetailVC(with: item))
        })
        return tempArr
    }()
    
    fileprivate lazy var scrollSegMentControlView: ScrollPageView = {
        let scroll: ScrollPageView = ScrollPageView(frame: CGRect(origin: self.view.frame.origin, size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - self.bottomBtnH)), segmentStyle: self.scrollSegmentStyle, titles: ReserveTimeStampManager.shared.vaildChildVcTitles, childVcs: self.childVCs, parentViewController: self)
        scroll.addLine(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 0.5), color: UIColor(hexString: "e3e3e5"))
        return scroll
    }()
    
    
    fileprivate var detailModel = ""
    fileprivate var confirmBtnClickedCallBack: callBack?
    
    convenience init(with model: String, Completion: @escaping callBack) {
        self.init()
        confirmBtnClickedCallBack = Completion
        detailModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        configData()
        configUI()
    }
}

extension TimeSelectDemoVC {
    //MARK:- configData
    
    fileprivate func configData() {
        ReserveTimeStampManager.shared.currentIndex = 0
        ReserveTimeStampManager.shared.isSelectedTime = false //默认进来未选中时间
        ReserveTimeStampManager.shared.origintimeStampArr = generateDataSource()
    }
    
    fileprivate func generateDataSource() -> [String] {
        return [
            "06:00",
            "06:30",
            "07:00",
            "07:30",
            "08:00",
            "08:30",
            "09:00",
            "09:30",
            "10:00",
            "10:30",
            "11:00",
            "11:30",
            "12:00",
            "12:30",
            "13:00",
            "13:30",
            "14:00",
            "14:30",
            "15:00",
            "15:30",
            "16:00",
            "16:30",
            "17:00",
            "17:30",
            "18:00",
            "18:30",
            "19:00",
            "19:30",
            "20:00",
            "20:30",
            "21:00"
        ]
    }
    

    //MARK:- configUI
    
    fileprivate func configUI() {
        title = "用餐时间"
        view.backgroundColor = UIColor.unityBackGroundColor()
        if #available(iOS 11.0, *) {
            scrollSegMentControlView.contentView.collectionView.contentInsetAdjustmentBehavior = .never
        }else {
            self.automaticallyAdjustsScrollViewInsets = false
        }// 必要的设置
        view.addSubview(scrollSegMentControlView)
        setUpBottomBtn()
        
        //        HPrint("ReserveTimeStampManager.shared.currentIndex:\(ReserveTimeStampManager.shared.selectedIndex)")
        //        scrollSegMentControlView.selectedIndex(selectedIndex: ReserveTimeStampManager.shared.selectedIndex, animated: true)
    }
    
    
    fileprivate func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didScroll(noti:)), name: NSNotification.Name.ScrollPageViewDidShowThePageNotification, object: nil)
    }
    
}


extension TimeSelectDemoVC {
    
    fileprivate func setUpBottomBtn() {
        view.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-tabBarHeight)
            make.left.width.equalToSuperview()
            make.height.equalTo(bottomBtnH)
        }
    }
    
    @objc fileprivate func bottomBtnClicked() {
        /** 选择过时间段才回调！否则直接返回 */
        callBack()
        let alert = UIAlertController(title: "选中了时间", message: ReserveTimeStampManager.shared.selectedTime, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func callBack() {
        if let completion = confirmBtnClickedCallBack, ReserveTimeStampManager.shared.isSelectedTime {
            completion()
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc fileprivate func didScroll(noti: NSNotification) {
        if let parentVCStr: String = noti.userInfo!["parentVC"] as! String? , parentVCStr == StringFromClass(self) as String{
            // HPrint("noti.userInfo:\(noti.userInfo!)",noti.userInfo!["currentIndex"] ?? " acceptted nil info notification！")
            if let index: Int = noti.userInfo!["currentIndex"] as! Int? {
                ReserveTimeStampManager.shared.currentIndex = index
            }
        }
        
    }
    
}


