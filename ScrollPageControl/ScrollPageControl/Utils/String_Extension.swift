//
//  String_Extension.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import UIKit


/// get AnyObject‘s class Name with String type
///
/// - Parameter object: AnyObject
/// - Returns: class with String type
public func StringFromClass(_ object: AnyObject) -> String {
    return NSStringFromClass(type(of: object)).components(separatedBy: ".").last! as String
}
public func ClassFromString(_ className: String) -> AnyClass! {
    
    /// get namespace
    let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
    
    /// get 'anyClass' with classname and namespace
    let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
    
    // return AnyClass!
    return cls;
}


/// get current String’s type
///
/// - Parameter type: anytype
/// - Returns: String type

public func StringFromType<T>(type: T) -> String {
    return String(describing: type.self).components(separatedBy: ".").last!
}

extension String {
    var length : Int {
        return self.count
    }
}

extension String {
    /// 从Any？ 转字符串
    static func stringValue(_ any: Any?, defaultValue: String = "") -> String {
        return any as? String ?? defaultValue
    }
}


extension String {
    
    //MARK: - 移除字符串的最后一位
    mutating func removeLast() {
        guard self.isEmpty else {
            let index = self.index(self.endIndex, offsetBy: -1)
            self.remove(at: index)
            return
        }
        HPrint("^_^``移除字符串最后一位失败,字符串为:\(self)")
    }
    
    //MARK: - 移除字符串的第一位
    mutating func removeFirst() {
        guard self.isEmpty else {
            let index = self.index(self.startIndex, offsetBy: 0)
            self.remove(at: index)
            return
        }
        HPrint("^_^``移除字符串第一位失败,字符串为:\(self)")
    }
    
    
    /// 将0..<3类型range转为需要的(lowerIndex, upperIndex)格式
    ///
    /// - Parameter range: 0..<3
    /// - Returns: (lowerIndex, upperIndex)
    func getStringRange(withIntRange range : Range<Int>) -> Range<String.Index>? {
        guard let lowerIndex = self.index(self.startIndex, offsetBy: range.lowerBound, limitedBy: self.endIndex) else { return nil }
        guard let upperIndex = self.index(self.startIndex, offsetBy: range.upperBound, limitedBy: self.endIndex) else { return nil }
        let strRange = Range(uncheckedBounds: (lowerIndex, upperIndex))
        return strRange
    }
    
    //MARK: - 得到字符串的对应Range<Int> 可能为空
    //    func getSubrange(withIntRange range : Range<Int>) -> String? {
    //        if let strRange = getStringRange(withIntRange: range){
    ////            return self.substring(with: strRange)
    //            return String(self[strRange])
    //        }else{
    //            HPrint("^_^``获取字符子串Range失败,字符串为：\(self) lowerIndex: \(range.lowerBound) upperIndex: \(range.upperBound)")
    //            return nil
    //        }
    //    }
    
    //MARK: - 移除字符串的对应Range<Int>
    /// 举个栗子:
    /// var str = "abcdefg"
    /// let range : Range = 0..<3
    /// str.remove(withIntRange: 0..<3)
    /// result "defg"
    /// - Parameters:
    ///   - range: Int类型的Range
    mutating func remove(withIntRange range : Range<Int>) {
        if let strRange = getStringRange(withIntRange: range){
            self.removeSubrange(strRange)
        }else{
            HPrint("^_^``移除字符串Range失败,字符串为：\(self) lowerIndex:\(range.lowerBound) upperIndex:\(range.upperBound)")
        }
    }
    
}


// MARK: - get String's size WithFont
extension String {
    public func stringSizeWithFont(_ font: UIFont, maxWidth: CGFloat) -> CGSize? {
        let text = NSString(cString: (self.cString(using: String.Encoding.utf8))!, encoding: String.Encoding.utf8.rawValue)
        let maxSize = CGSize(width: maxWidth, height: CGFloat(MAXFLOAT))
        let size = text?.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
        return size
    }
    
    public func stringSizeWithFont(_ font: UIFont) -> CGSize? {
        return self.stringSizeWithFont(font, maxWidth: CGFloat(MAXFLOAT))
    }
}
extension String {
    /// 转换时间戳为"年/月/日"的方法
    ///
    /// - Parameter timeStamp: 时间戳字符串
    /// - Returns: 转换好的时间
    static func timeStampToString(timeStamp : String,dateFormat: String = "yyyy/MM/dd") -> String{
        let timeSta : TimeInterval = Double(timeStamp) ?? 0
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: timeSta)
        HPrint(dfmatter.string(from: date))
        return dfmatter.string(from: date)
    }
    
    /// 转换时间戳的方法
    ///
    /// - Parameter timeStamp: 时间戳字符串
    /// - Returns: 转换好的时间
    func timestampToString(withDateFormat dateFormat: String = "yyyy-MM-dd HH:mm") -> String{
        let timeSta : TimeInterval = NSString(string: self).doubleValue/1000
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    /// 服务器时间比对系统时间出时间规则
    ///
    /// - Parameter timeString: 时间戳
    /// - Returns: 规则时间
    func contrastCurrentTime() -> String{
        let timeNum = (Int64(self) ?? 0)
        let timeInterval : TimeInterval = Date().timeIntervalSince1970
        let timeCurrentStamp = Int64(timeInterval)
        //系统当前时间-服务器返回时间
        let temp = (timeCurrentStamp * 1000) - timeNum
        //利用差值比对
        if temp < (1000 * 60 * 5){
            return "刚刚"
        }else if temp < (1000 * 60 * 60){
            return "\(temp / 60000)" + "分钟前"
        }else if temp < (1000 * 60 * 60 * 24){
            return "\(temp / 3600000)" + "小时前"
        }else{
            return self.timestampToString()
        }
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                HPrint(error.localizedDescription)
            }
        }
        return nil
    }
}


extension String
{
    func substring(from index: Int) -> String
    {
        if (index < 0 || index > self.count)
        {
            HPrint("index \(index) out of bounds")
            return ""
        }
        //        return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    func substring(to index: Int) -> String
    {
        if (index < 0 || index > self.count)
        {
            HPrint("index \(index) out of bounds")
            return ""
        }
        //        return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    func substring(start: Int, end: Int) -> String
    {
        if (start < 0 || start > self.count)
        {
            HPrint("start index \(start) out of bounds")
            return ""
        }
        else if end < 0 || end > self.count
        {
            HPrint("end index \(end) out of bounds")
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        let range = startIndex..<endIndex
        
        //        return self.substring(with: range)
        return String(self[range])
    }
    
}

// MARK: - 正则校验

extension String {
    /**!
     常用的正则表达式
     http://www.cnblogs.com/zxin/archive/2013/01/26/2877765.html
     匹配手机号 : ^1[3,8]\d{9}|14[5,7,9]\d{8}|15[^4]\d{8}|17[^2,4,9]\d{8}$
     移动号段:
     135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188
     联通号段:
     130、131、132、145、155、156、175、176、185、186
     电信号段:
     133、1349[3]、149、153、173、177、180、181、189
     虚拟号段:
     1700、1701、1702、1703、1704、1705、1706、1707、1708、1709、171
     wiki
     
     匹配IP : ((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)
     
     匹配大于8个字符且首字符为大写字母的密码: ^[A-Z]\w{7,}$
     */
    
    func checkoutPhoneNum(for regex: String = "^((13[0-9])|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$") -> Bool {
        return verify(by: regex)
    }
    /**!
     ^[A-Za-z0-9]+$ 或 ^[A-Za-z0-9]{4,40}$ 字母或者数字的密码
     */
    func verifyPwd(by pwdRegix: String = "^[A-Za-z0-9]+$") -> Bool {
        return verify(by:pwdRegix)
    }
    
    func verify(by regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            let resultArray = results.map { nsString.substring(with: $0.range) }
            HPrint(resultArray.count)
            if resultArray.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error {
            if isInDebuggingMode {
                fatalError("无效正则表达式: \(error.localizedDescription)")
            }else {
                return false
            }
        }
    }
    //MARK: -- 税号正则
    mutating func isIdNumber() -> Bool {
        //"^([a-zA-Z0-9]{15})$|^([a-zA-Z0-9]{18})$|^([a-zA-Z0-9]{20})$"
        let id = "^([a-zA-Z0-9]{15})$|^([a-zA-Z0-9]{18})$|^([a-zA-Z0-9]{20})$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",id)
        if (regextestmobile.evaluate(with: self) == true)
        {
            return true
        }else {
            return false
        }
    }
    /// 校验输入的邮箱是否正确
    ///
    /// - Parameter email: 邮箱字符串
    /// - ruleString: 正则校验字符串
    /// - Returns: 正确与否
    //"^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,4}$"
    //"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$"
    func validateEmail(ruleString: String = "^([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,4}$") -> Bool{
        //校验输入的邮箱是否正确的正则
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", ruleString)
        return emailTest.evaluate(with: self)
    }
}

extension String {
    // MARK: - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
    func getFirstLetterFromString() -> (String) {
        
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: self)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母转换成大写
        let strPinYin = polyphoneStringHandle(nameString: self, pinyinString: pinyinString).uppercased()
        // 截取大写首字母
        let firstString = String(strPinYin[..<strPinYin.index(strPinYin.startIndex, offsetBy: 1)])
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    
    /// 多音字处理
    func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }
    
}
extension String {
    func format(f: Int) -> String {
        return String(format: "%.\(f)f", self)//"%.2f"
    }
}
extension String {
    func dialingPhone() {
        guard let url = URL(string: "telprompt://" + self) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

