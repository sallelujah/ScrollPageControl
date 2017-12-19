//
//  reserveTimePickerDetailView.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import UIKit

class reserveTimePickerDetailView: UIView {
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(15, 20, 10, 20);
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.unityBackGroundColor()
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ID")
        return view
    }()
    
    fileprivate var dataSource: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    var sectionDataSource: [String] {
    //        let subArray = Array(dataSource.prefix(3))
    //        HPrint("subArray:\(subArray)")
    //        return subArray
    //    }
    //MARK:- configUI
    func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    //MARK:- Actions -if needed
    
    func reload(by timeArr: [String]) {
        dataSource = timeArr
        //        HPrint(dataSource)
        collectionView.reloadData()
        //        HPrint("sectionDataSource:\(sectionDataSource)")
    }
    
}
//MARK:- Delegate

extension reserveTimePickerDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 62, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0
        
        let label =  UILabel(frame: CGRect(origin: CGPoint.zero, size: cell.bounds.size))
        label.text = dataSource[indexPath.item]
        label.textAlignment = .center
        label.textColor = UIColor.unityTextColor()
        label.font = UIFont.systemFont(ofSize: 13)
        label.layer.borderColor = UIColor(hexString: "E5E5E5").cgColor
        label.layer.borderWidth = 1
        //        label.roundedCorrner(radius: 2)
        cell.contentView.removeAllSubviews()
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        ReserveTimeStampManager.shared.selectedHour = dataSource[indexPath.item]
        //        HPrint("ReserveDateManage.share.selectedHour:\(ReserveTimeStampManager.shared.selectedHour)")
        cell?.backgroundColor = UIColor(hexString: "ffeeee")
        cell?.layer.borderColor = UIColor(hexString: "ff4d4d").cgColor
        cell?.layer.borderWidth = 1
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .white
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 0
    }
    
    
}


