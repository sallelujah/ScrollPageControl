//
//  UILabel_Extension.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import UIKit


extension UILabel {
    
    /**!
     return current Label's rect
     */
    open func boundingRect(with size: CGSize = CGSize(width: Double(MAXFLOAT), height: 0.0), options: NSStringDrawingOptions = [], attributes: [String : Any]? = nil, context: NSStringDrawingContext? = nil) -> CGRect? {
        let rect = self.text?.boundingRect(with: CGSize(width: Double(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: self.font], context: nil)
        return rect
    }
    
    /**! return current Label.rect.size */
    open func boundingRectSize() -> CGSize {
        return self.boundingRect()?.size ?? CGSize.zero
    }
}


// MARK: - TaptoCallTelephone
extension UILabel {
    func addTaptoCallTelephone() -> Void {
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(telephoneLabelOnClick))
        tapGes.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGes)
    }
    
    @objc func telephoneLabelOnClick() {
        if let phone = self.text {
            phone.dialingPhone()
        }
    }
    
    //改变行间距
    func changeLineSpace(space: CGFloat){
        if self.text == nil || self.text == ""{
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text?.length)!))
        self.attributedText = attributedString
        self.sizeToFit()
    }
}



