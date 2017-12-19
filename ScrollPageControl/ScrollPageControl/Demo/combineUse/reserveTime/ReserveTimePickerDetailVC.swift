//
//  ReserveTimePickerDetailVC.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import UIKit

class ReserveTimePickerDetailVC: UIViewController {
    
    // MARK: - lazy Views & other configuratios
    fileprivate let tabBtnsViewH: CGFloat = 45
    fileprivate lazy var tabBtnsView: ReserveTimePickerTabView = {
        let view = ReserveTimePickerTabView(with: self.btnTypeArr)
        return view
    }()
    
    fileprivate lazy var detailView: reserveTimePickerDetailView = {
        let view = reserveTimePickerDetailView(frame: CGRect.zero)
        return view
    }()
    fileprivate var btnTypeArr: [mealTimeBtnType] = []
    fileprivate var dataSource: TimeStampTuples = ([],[],[])
    
    convenience init(with timeTuples: TimeStampTuples) {
        self.init()
        dataSource = timeTuples
        getBtnTypeArr()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

extension ReserveTimePickerDetailVC {
    //MARK:- configData
    
    fileprivate func getBtnTypeArr() {
        if dataSource.breakFirst.count > 0 {
            btnTypeArr.append(mealTimeBtnType.breakFirst)
        }
        if dataSource.launch.count > 0 {
            btnTypeArr.append(mealTimeBtnType.launch)
        }
        if dataSource.dinner.count > 0 {
            btnTypeArr.append(mealTimeBtnType.dinner)
        }
        
        //        HPrint("btnTypeArr:\(btnTypeArr)")
    }
    
    //MARK:- configUI
    
    fileprivate func configUI() {
        setUpTabBtnsView()
        setUpDetailView()
    }
    
    fileprivate func setUpTabBtnsView() {
        if btnTypeArr.count > 1 {
            view.addSubview(tabBtnsView)
            tabBtnsView.snp.makeConstraints { (make) in
                make.top.left.width.equalToSuperview()
                make.height.equalTo(tabBtnsViewH)
            }
            tabBtnsView.btnAction = { (index: Int) in
                //                HPrint(index)
                switch index {
                case 0:
                    self.detailView.reload(by: self.dataSource.breakFirst)
                case 1:
                    self.detailView.reload(by: self.dataSource.launch)
                case 2:
                    self.detailView.reload(by: self.dataSource.dinner)
                default: break
                }
            }
            
        }
    }
    
    fileprivate func setUpDetailView() {
        view.addSubview(detailView)
        let detailViewTop = btnTypeArr.count > 1 ? tabBtnsViewH : 0
        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(detailViewTop)
            make.left.width.equalToSuperview()
            make.height.equalToSuperview().offset(-detailViewTop)
        }
        //        HPrint("dataSource:\(self.dataSource)")
        if dataSource.breakFirst.count > 0 {
            detailView.reload(by: dataSource.breakFirst)
        }else if dataSource.launch.count > 0 {
            detailView.reload(by: dataSource.launch)
        }else if dataSource.dinner.count > 0 {
            detailView.reload(by: dataSource.dinner)
        }
        
    }
    
}

