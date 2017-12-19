//
//  NotificationName_Extension.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import Foundation
extension NSNotification.Name {
    public static let ScrollPageViewDidShowThePageNotification = NSNotification.Name(rawValue: "ScrollPageViewDidShowThePageNotification")
    /** 跨层级控制ScrollPapgeControl 滚动到指定的index */
    public static let ScrollPageViewShouldShowThePageNotification = NSNotification.Name(rawValue: "ScrollPageViewShouldShowThePageNotification")

}
