//
//  Double_Extension.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import Foundation
extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self/1000)
        
        let dateFormatter = DateFormatter()
        /**!
         GMT = 格林威治标准时间
         CST = 中国标准时间
         CET = 欧洲中部时间
         */
        
        dateFormatter.locale = Locale(identifier: "GMT")
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    func Since1970Date() -> Date {
        return Date(timeIntervalSince1970: self / 1000)
    }
    
    var minString: String {
        get{
            return toMinString()
        }
    }
    
    var secString: String {
        get{
            return toSecString()
        }
    }
    /** "yyyy年MM月dd日" */
    func toMinString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self.Since1970Date())
    }
    func toSecString(format: String = "yyyy-MM-dd HH:mm:ss") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self.Since1970Date())
    }
    
    /**!
     Thursday, Mar 23, 2017
     EEEE, MMM d, yyyy
     03/23/2017
     MM/dd/yyyy
     03-23-2017 06:59
     MM-dd-yyyy HH:mm
     Mar 23, 6:59 AM
     MMM d, h:mm a
     March 2017
     MMMM yyyy
     Mar 23, 2017
     MMM d, yyyy
     Thu, 23 Mar 2017 06:59:49 +0000
     E, d MMM yyyy HH:mm:ss Z
     2017-03-23T06:59:49+0000
     yyyy-MM-dd'T'HH:mm:ssZ
     23.03.17
     dd.MM.yy
     */
    /** 参照表如上 */
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self.Since1970Date())
    }
    
}

extension Double {
    
    /** f: Int 输出位数 */
    /** 有时候我们需要将3.3333保留两位小数变成3.33。 */
    func format(f: Int) -> String {
        return String(format: "%.\(f)f", self)//"%.2f"
    }
    func dFormat(f: Int) -> String{
        return String(format: "%.\(f)f", self)//"%.2f"
    }
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    var roundTo2f: Double {return Double((100 * self).rounded()/100)  }
}
extension Int {
    
    /** f: Int 输出位数*/
    /**  类似01，02，001，002这样的格式。 */
    func format(f: Int) -> String {
        return String(format: "%.\(f)d", self)//"%.2d"
    }
    
}



