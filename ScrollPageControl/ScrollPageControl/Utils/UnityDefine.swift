//
//  UnityDefine.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import Foundation
import UIKit


public var NavigationBarH: CGFloat {
    return 44
}
/// App's name (if applicable).
public var appDisplayName: String? {
    // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
    return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
}

/// App's bundle ID (if applicable).
public var appBundleID: String? {
    return Bundle.main.bundleIdentifier
}

/// StatusBar height
public var statusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}


/// TabBar height
public var tabBarHeight: CGFloat {
    return 49
}
/// 网络请求统一的分页数量
public var pageCount: Int {
    return 20
}

/// App current build number (if applicable).
public var appBuild: String {
    if let str = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
        return str
    }else {
        return ""
    }
}

/// Application icon badge current number.
public var applicationIconBadgeNumber: Int {
    get {
        return UIApplication.shared.applicationIconBadgeNumber
    }
    set {
        UIApplication.shared.applicationIconBadgeNumber = newValue
    }
}

/// App's current version (if applicable).
public var appVersion: String {
    //    let executable = Bundle.main.infoDictionary?[kCFBundleExecutableKey as String] as? String ?? "Unknown"
    //    let bundle = Bundle.main.infoDictionary?[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
    //    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    //    let appBuild = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? "Unknown"
    //    HPrint(executable,bundle,appVersion,appBuild)
    if let str = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        return str
    }else {
        return ""
    }
}

/// Current battery level.
public var batteryLevel: Float {
    return UIDevice.current.batteryLevel
}

/// Shared instance of current device.
public var currentDevice: UIDevice {
    return UIDevice.current
}

/// Screen height.
public var screenH: CGFloat {
    return UIScreen.main.bounds.height
}

/// Current device model.
public var deviceModel: String {
    return UIDevice.current.model
}

/// Current device name.
public var deviceName: String {
    return UIDevice.current.name
}

public var udid: UUID? {
    return UIDevice.current.identifierForVendor
}

public var udidStr: String {
    return UIDevice.current.identifierForVendor?.uuidString ?? "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
}
public func randomString(length: Int) -> String {
    
    let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-"/** "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-" */
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}
/// Current orientation of device.
public var deviceOrientation: UIDeviceOrientation {
    return UIDevice.current.orientation
}

/// Screen width.
public var screenW: CGFloat {
    return UIScreen.main.bounds.width
}

/// Check if app is running in debug mode.
public var isInDebuggingMode: Bool {
    // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
    #if DEBUG
        return true
    #else
        return false
    #endif
}

/// Check if app is running in Production mode.
public var isInProductionMode: Bool {
    // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
    #if DEBUG
        return false
    #else
        return true
    #endif
}

/// Check if multitasking is supported in current device.
public var isMultitaskingSupported: Bool {
    return UIDevice.current.isMultitaskingSupported
}

/// Current status bar network activity indicator state.
public var isNetworkActivityIndicatorVisible: Bool {
    get {
        return UIApplication.shared.isNetworkActivityIndicatorVisible
    }
    set {
        UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
    }
}

/// Check if device is iPad.
public var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

/// Check if device is iPhone.
public var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}
public var isPhoneX: Bool {
    //    HPrint(UIDevice.current.name,UIDevice.current.model,UIDevice.current.modelName)
    return UIDevice.current.modelName == "iPhone X"
}
/// Check if device is registered for remote notifications for current app (read-only).
public var isRegisteredForRemoteNotifications: Bool {
    return UIApplication.shared.isRegisteredForRemoteNotifications
}

/// Check if application is running on simulator (read-only).
public var isRunningOnSimulator: Bool {
    // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
    #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
        return true
    #else
        return false
    #endif
}

/// Status bar visibility state.
public var isStatusBarHidden: Bool {
    get {
        return UIApplication.shared.isStatusBarHidden
    }
    set {
        UIApplication.shared.isStatusBarHidden = newValue
    }
}

/// Key window (read only, if applicable).
public var keyWindow: UIView? {
    return UIApplication.shared.keyWindow
}

/// Most top view controller (if applicable).
public var mostTopViewController: UIViewController? {
    get {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    set {
        UIApplication.shared.keyWindow?.rootViewController = newValue
    }
}

/// Shared instance UIApplication.
public var sharedApplication: UIApplication {
    return UIApplication.shared
}

/// Current status bar style (if applicable).
public var statusBarStyle: UIStatusBarStyle? {
    get {
        return UIApplication.shared.statusBarStyle
    }
    set {
        if let style = newValue {
            UIApplication.shared.statusBarStyle = style
        }
    }
}

/// System current version (read-only).
public var systemVersion: String {
    return UIDevice.current.systemVersion
}

/// Shared instance of standard UserDefaults (read-only).
public var userDefaults: UserDefaults {
    return UserDefaults.standard
}



class UnityDefine: NSObject {
    
    /// Called when user takes a screenshot
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    public static func didTakeScreenShot(_ action: @escaping () -> ()) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { notification in
            action()
        }
    }
    
    /// Object from UserDefaults.
    ///
    /// - Parameter forKey: key to find object for.
    /// - Returns: Any object for key (if exists).
    public static func object(forKey: String) -> Any? {
        return UserDefaults.standard.object(forKey: forKey)
    }
    
    /// String from UserDefaults.
    ///
    /// - Parameter forKey: key to find string for.
    /// - Returns: String object for key (if exists).
    public static func string(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    /// Integer from UserDefaults.
    ///
    /// - Parameter forKey: key to find integer for.
    /// - Returns: Int number for key (if exists).
    public static func integer(forKey: String) -> Int? {
        return UserDefaults.standard.integer(forKey: forKey)
    }
    
    /// Double from UserDefaults.
    ///
    /// - Parameter forKey: key to find double for.
    /// - Returns: Double number for key (if exists).
    public static func double(forKey: String) -> Double? {
        return UserDefaults.standard.double(forKey: forKey)
    }
    
    /// Data from UserDefaults.
    ///
    /// - Parameter forKey: key to find data for.
    /// - Returns: Data object for key (if exists).
    public static func data(forKey: String) -> Data? {
        return UserDefaults.standard.data(forKey: forKey)
    }
    
    /// Bool from UserDefaults.
    ///
    /// - Parameter forKey: key to find bool for.
    /// - Returns: Bool object for key (if exists).
    public static func bool(forKey: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    /// Array from UserDefaults.
    ///
    /// - Parameter forKey: key to find array for.
    /// - Returns: Array of Any objects for key (if exists).
    public static func array(forKey: String) -> [Any]? {
        return UserDefaults.standard.array(forKey: forKey)
    }
    
    /// Dictionary from UserDefaults.
    ///
    /// - Parameter forKey: key to find dictionary for.
    /// - Returns: ictionary of [String: Any] for key (if exists).
    public static func dictionary(forKey: String) -> [String: Any]? {
        return UserDefaults.standard.dictionary(forKey: forKey)
    }
    
    /// Float from UserDefaults.
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float number for key (if exists).
    public static func float(forKey: String) -> Float? {
        return UserDefaults.standard.object(forKey: forKey) as? Float
    }
    
    /// Save an object to UserDefaults.
    ///
    /// - Parameters:
    ///   - value: object to save in UserDefaults.
    ///   - forKey: key to save object for.
    public static func set(value: Any?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    /// Class name of object as string.
    ///
    /// - Parameter object: Any object to find its class name.
    /// - Returns: Class name for given object.
    public static func typeName(for object: Any) -> String {
        let type = Swift.type(of: object.self)
        return String.init(describing: type)
    }
}






