//
//  UIView_Extension.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import UIKit
extension UIView{
    var x:CGFloat{
        get{ return self.frame.origin.x }
        set{ self.frame = CGRect(x: newValue, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height) }
    }
    var y:CGFloat{
        get{ return self.frame.origin.y }
        set{ self.frame = CGRect(x: self.frame.origin.x, y: newValue, width: self.frame.size.width, height: self.frame.size.height) }
    }
    
    var width:CGFloat{
        get{ return self.frame.size.width }
        set{ self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height) }
    }
    
    var height:CGFloat{
        get{ return self.frame.size.height }
        set{ self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue) }
    }
    
    var left: CGFloat { return self.x }
    var right: CGFloat { return self.x + self.width }
    var top: CGFloat { return self.y }
    var bottom: CGFloat { return self.y + self.height }
    //    var bottom: CGFloat {
    //        get{ return self.y + self.height }
    //        set{ self.frame = CGRect(x: self.frame.origin.x, y: newValue, width: self.frame.size.width, height: self.frame.size.height) }
    //    }
    /// 提供给外界(基于self)的右上角锚点：CGPoint
    var rightTopAnchor: CGPoint { return CGPoint(x: self.width, y: 0) }
    
    // size
    var size: CGSize {
        get { return self.frame.size }
        set { self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue.width, height: newValue.height) }
    }
    // origin
    var origin: CGPoint {
        get { return self.frame.origin }
        set { self.frame.origin = newValue }
    }
    
    var centerX: CGFloat { return self.center.x }
    var centerY: CGFloat { return self.center.y }
    
}
extension UIView {
    
    public func roundedCorrner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    public func roundedRectangleFilter() {
        self.roundedCorrner(radius: self.height / 2)
    }
    
    public func circleFilter() {
        self.roundedCorrner(radius: self.width / 2)
    }
    
    public func border(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    public func removeSublayers() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    public func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    public func hasViewClass(targetClass: AnyClass) -> Bool {
        for childView in self.subviews {
            if childView.isMember(of: targetClass) {
                return true
            }
        }
        return false
    }
    
}


// MARK: - 获取承载当前View的Controller
extension UIView {
    
    var viewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let responder = responder as? UIViewController {
                return responder
            }
            responder = responder?.next
        }
        return nil
    }
    
}


enum BorderPosition{
    case  top, left, bottom, right
}

extension UIView{
    
    public func addLine(frame: CGRect) {
        addLine(frame: frame, color: UIColor.lightGray)
    }
    
    public func addLine(frame: CGRect, color: UIColor) {
        addLine(frame: frame, color: color, alpha: nil)
    }
    
    public func addLine(frame: CGRect, color: UIColor, alpha: CGFloat?){
        let line = UIView(frame:frame)
        line.backgroundColor = color
        if let alpha = alpha {
            self.alpha = alpha
        }
        self.addSubview(line)
    }
    
    /// addBorderLayer
    /// - Parameters:
    func addBorderLayer(frame: CGRect, color: UIColor){
        let borderLayer: CALayer =  CALayer()
        borderLayer.backgroundColor = color.cgColor
        borderLayer.frame = frame
        self.layer.addSublayer(borderLayer)
    }
    
    func addBorderLayer(layerWidth: CGFloat, positon: BorderPosition, color: UIColor) {
        var borderLayerFrame: CGRect
        
        switch positon {
        case .top:
            borderLayerFrame = CGRect(x: 0, y: 0, width: self.width, height: layerWidth)
        case .left:
            borderLayerFrame = CGRect(x: 0, y: 0, width: layerWidth, height: self.height)
        case .bottom:
            borderLayerFrame = CGRect(x: 0, y: self.height - layerWidth, width: self.width, height: layerWidth)
        case .right:
            borderLayerFrame = CGRect(x: self.width - layerWidth, y: 0, width: layerWidth, height: self.height)
        }
        self.addBorderLayer(frame: borderLayerFrame, color: color)
        
    }
}

extension UIView {
    var parentVC: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}


extension UIView {
    
    var screenShot: UIImage?  {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 2);
        if let _ = UIGraphicsGetCurrentContext() {
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}


