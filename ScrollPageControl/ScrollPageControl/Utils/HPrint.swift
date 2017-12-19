//
//  HPrint.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//

import Foundation

/// Debug状态下打印  Release不打印
///
/// - Parameters:
///   - items: 需要打印的内容 ","号分割
///   - file: 文件名-默认参数不需要传
///   - lineNumeber: 方法在文件中的行数-默认参数不需要传
///   - FuncName: 方法的名字-默认参数不需要传
public func HPrint(_ items: Any...,file : String = #file, lineNumeber : Int = #line, FuncName : String = #function) {
    
    if isInDebuggingMode {
        let fileName = (file as NSString).lastPathComponent.components(separatedBy: ".")[0]
        
        print("\n\(fileName).\(FuncName)【Line:\(lineNumeber)】\n************************************************************************************************************")
        for item in items{
            JSONPrettyPrinted(value: item)
        }
        //        print("****************")
    }
    
}


public func JSONPrettyPrinted(value: Any, prettyPrinted:Bool = false)  -> Void {
    
    let options = JSONSerialization.WritingOptions.prettyPrinted
    
    if JSONSerialization.isValidJSONObject(value) {
        
        do{
            let data = try JSONSerialization.data(withJSONObject: value, options: options)
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print(string as String)
            }
        }catch {
            print(value,"\n")
        }
        
    }else {
        print(value,"\n")
    }
}

