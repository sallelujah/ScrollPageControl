//
//  ReserveTimeStampManager.swift
//  ScrollPageControl
//
//  Created by Lawrence on 2017/12/19.
//  Copyright © 2017年 lawrece. All rights reserved.
//


import Foundation

typealias TimeStampTuples = (breakFirst: [String], launch: [String], dinner: [String])
typealias TimeOfDay = (hour: Int, minute: Int, second: Int)
typealias weekDayTuple = (week: String, day: String)
class ReserveTimeStampManager {
    
    static let shared = ReserveTimeStampManager()
    
    var origintimeStampArr = [String]()
    
    func timeBucketTuples(isToday: Bool = false) -> TimeStampTuples {
        
        let calender = Calendar.autoupdatingCurrent
        let strings: [String] = origintimeStampArr.filter(){!$0.isEmpty} /** 过滤空数据 */
        let parser0 = DateFormatter()
        parser0.dateFormat = "HH:mm:ss"
        /** 将ReserveTimeStampManager.shared.origintimeStampArr 时间字符串切割为 TimeOfDay 格式元祖，方便分时段比对切割，
         体会到了元祖的强大之处了吧*/
        let timesOfDays: [TimeOfDay] = strings.map({ (string) -> TimeOfDay in
            if let dataFrom = parser0.date(from: "\(string):00") {
                let components = calender.dateComponents([.hour, .minute, .second], from: dataFrom)
                return (hour: components.hour ?? 00, minute: components.minute ?? 00, second: components.second ?? 00)
            }else {
                return (hour: 00, minute: 00, second: 00)
            }
        })
        
        /** 产品定义的早中晚时间段 */
        let breakfirstAreas: [TimeOfDay] = [(hour: 0, minute: 0, second: 0), (hour: 7, minute: 30, second: 0)] /** 00:00-7:30 */
        let launchAreas: [TimeOfDay] = [(hour: 8, minute: 0, second: 0), (hour: 15, minute: 30, second: 0)]  /** 08:00-15:30 */
        let dinnerAreas: [TimeOfDay] = [(hour: 16, minute: 0, second: 0), (hour: 23, minute: 30, second: 0)] /** 16:00-23:30 */
        
        var allAreas: (breakFirst: [TimeOfDay], launch: [TimeOfDay], dinner: [TimeOfDay]) = ([],[],[])
        
        allAreas.breakFirst = timesOfDays.filter(){ $0 >= breakfirstAreas[0] && $0 <= breakfirstAreas[1] }   // breakFirst
        allAreas.launch = timesOfDays.filter(){ $0 >= launchAreas[0] && $0 <= launchAreas[1] }          // launch
        allAreas.dinner = timesOfDays.filter(){ $0 >= dinnerAreas[0] && $0 <= dinnerAreas[1] }          // dinner
        
        var arr: TimeStampTuples = ([],[],[])
        if isToday { /** 今天已经过时的时段过滤*/
            parser0.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // yyyy-MM-dd HH:mm:ss Z
            let currentDate = Date()
            if let dataFrom = parser0.date(from: "\(currentDate)") {
                let currentComponents = calender.dateComponents([.hour, .minute, .second], from: dataFrom)
                let currentDateTuple: TimeOfDay = (hour: currentComponents.hour ?? 00, minute: currentComponents.minute ?? 00, second: currentComponents.second ?? 00)
                allAreas.breakFirst = allAreas.breakFirst.filter() { $0 >= currentDateTuple }
                allAreas.launch = allAreas.launch.filter() { $0 >= currentDateTuple }
                allAreas.dinner = allAreas.dinner.filter() { $0 >= currentDateTuple }
                //            HPrint("allAreas:\(allAreas)")
                if allAreas.breakFirst.count != 0 {
                    arr.breakFirst.append("现在")
                } else if allAreas.launch.count != 0 {
                    arr.launch.append("现在")
                } else if allAreas.dinner.count != 0 {
                    arr.dinner.append("现在")
                }
            }
        }
        allAreas.breakFirst.forEach { (tuple: (hour: Int, minute: Int, second: Int)) in
            arr.breakFirst.append("\(tuple.hour.format(f: 2)):\(tuple.minute.format(f: 2))")
        }
        allAreas.launch.forEach { (tuple: (hour: Int, minute: Int, second: Int)) in
            arr.launch.append("\(tuple.hour.format(f: 2)):\(tuple.minute.format(f: 2))")
        }
        allAreas.dinner.forEach { (tuple: (hour: Int, minute: Int, second: Int)) in
            arr.dinner.append("\(tuple.hour.format(f: 2)):\(tuple.minute.format(f: 2))")
        }
        //        HPrint(arr)
        return arr
    }
    
    
    func getWeekDayTuples(with area: (from: Int, to: Int) = (from: 0, to: 7)) -> [weekDayTuple] {
        var weekDayTuples = [weekDayTuple]()
        for i in area.from...area.to {
            
            let intervalPerday = TimeInterval(i * 24 * 60 * 60)
            let currentDay = Date(timeIntervalSinceNow: intervalPerday)
            /** day */
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "M月d日"
            let dayStr = dayFormatter.string(from: currentDay)
            /** week */
            let weekFormatter = DateFormatter()
            weekFormatter.dateFormat = "EEEE"
            var weekStr = weekFormatter.string(from: currentDay)
            switch i {
            case 0:
                weekStr = "今天"
            case 1:
                weekStr = "明天"
            case 2:
                weekStr = "后天"
            default:
                weekStr = weekFormatter.string(from: currentDay)
            }
            /**
             [(week: "今天", day: "7月27日"), (week: "明天", day: "7月28日"), (week: "后天", day: "7月29日"), (week: "星期日", day: "7月30日"), (week: "星期一", day: "7月31日"), (week: "星期二", day: "8月1日"), (week: "星期三", day: "8月2日"), (week: "星期四", day: "8月3日")]
             */
            weekDayTuples.append((week: weekStr, day: dayStr))
        }
        //        HPrint(weekDayTuples)
        return weekDayTuples
    }
    
    
    var isValidDateToday: Bool {
        let todayData: TimeStampTuples = timeBucketTuples(isToday: true)
        return !todayData.breakFirst.isEmpty || !todayData.launch.isEmpty || !todayData.dinner.isEmpty
    }
    
    var vaildWeekDayTuplesArr: [weekDayTuple] {
        var vaildArr = getWeekDayTuples()
        if !isValidDateToday && vaildArr.count > 0{
            //            HPrint("vaildArr:\(vaildArr)")
            vaildArr.removeFirst()
            //            HPrint("vaildArr:\(vaildArr)")
        }
        return vaildArr
    }
    
    var vaildChildVcTitles: [String] {
        var arr = [String]()
        vaildWeekDayTuplesArr.forEach { (item: (week: String, day: String)) in
            arr.append(item.week + "\n" + item.day)
        }
        return arr
    }
    
    var vaildChildVcDataSource: [TimeStampTuples] {
        var arr: [TimeStampTuples] = []
        vaildChildVcTitles.forEach { (_) in
            arr.append(timeBucketTuples())
        }
        if isValidDateToday {
            //            HPrint("arr:\(arr)")
            arr[0] = timeBucketTuples(isToday: true)
            //            HPrint("arr:\(arr)")
        }
        return arr
    }
    
    
    var currentIndex = 0
    var selectedDay = ""
    var selectedWeek = ""
    var selectedIndex = 0 /** 选了具体时段的index 没选择下面时段的时候 即使滚动切换了顶部日期tab，亦为空 */
    var isSelectedTime = false
    
    var selectedTime: String {
        if isSelectedTime {
            return "\(selectedDay) \(selectedWeek) \(selectedHour)"
        }else {
            return ""
        }
    }
    
    var selectedHour = "" {/** e.s: 00:00 */
        didSet {
            isSelectedTime = true
            selectedIndex = currentIndex
            selectedDay = vaildWeekDayTuplesArr[selectedIndex].day
            selectedWeek = vaildWeekDayTuplesArr[selectedIndex].week
        }
    }
    var year: String {
        get{
            if let currentDate = Calendar.current.date(byAdding: Calendar.Component.day, value: currentIndex, to: Date()) {
                let calendar = Calendar.current
                let dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
                let year = "\(dateComponents.year ?? 00)-\(dateComponents.month ?? 00)-\(dateComponents.day ?? 00)"
                return year
            }else {
                return "00-00-00"
            }
        }
    }
    
    var selectedHourTuple: TimeOfDay? {
        get {
            HPrint(selectedHour)
            var temHour = selectedHour
            if let str = currentDateStr, selectedHour == "现在" {
                temHour = str
            }else {
                temHour = temHour + ":00"//对齐格式，选中的时间没有精确到秒，手动拼接上
            }
            let calender = Calendar.autoupdatingCurrent
            let parser0 = DateFormatter()
            parser0.dateFormat = "HH:mm:ss"
            if let dataFrom = parser0.date(from: "\(temHour)") {
                let components = calender.dateComponents([.hour, .minute, .second], from: dataFrom)
                if let hour = components.hour, let min = components.minute, let sec = components.second {
                    return (hour: hour, minute: min, second: sec)
                }else {
                    return nil
                }
            }else {
                return nil
            }
        }
    }
    var currentDateStr: String? {
        get {
            let calender = Calendar.autoupdatingCurrent
            let parser0 = DateFormatter()
            parser0.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // yyyy-MM-dd HH:mm:ss Z
            let currentDate = Date()
            if let dataFrom = parser0.date(from: "\(currentDate)") {
                let currentComponents = calender.dateComponents([.hour, .minute, .second], from: dataFrom)
                if let hour = currentComponents.hour, let min = currentComponents.minute, let sec = currentComponents.second {
                    return "\(hour)" + ":" + "\(min)" + ":" + "\(sec)"
                }else {
                    return nil
                }
            }else {
                return nil
            }
        }
    }
    var currentDateTuple: TimeOfDay? {
        get{
            let calender = Calendar.autoupdatingCurrent
            let parser0 = DateFormatter()
            parser0.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // yyyy-MM-dd HH:mm:ss Z
            let currentDate = Date()
            if let dataFrom = parser0.date(from: "\(currentDate)") {
                let currentComponents = calender.dateComponents([.hour, .minute, .second], from: dataFrom)
                if let hour = currentComponents.hour, let min = currentComponents.minute, let sec = currentComponents.second {
                    return (hour: hour, minute: min, second: sec)
                }else {
                    return nil
                }
            }else {
                return nil
            }
        }
    }
    
}






