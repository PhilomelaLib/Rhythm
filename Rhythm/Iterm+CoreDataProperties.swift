//
//  Iterm+CoreDataProperties.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//
//

import CoreData
import Foundation
//import nav
import UIKit

extension Iterm {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Iterm> {
        return NSFetchRequest<Iterm>(entityName: "Iterm")
    }

    @NSManaged public var addingDate: Date?
    
    @NSManaged public var isDoone: Bool
    @NSManaged public var doneDate: Date?
    
    /// 已经认领
    @NSManaged public var isDoing: Bool
    
    /// 正在干活
    @NSManaged public var isWorking: Bool
    
    @NSManaged public var remember: Date?
    @NSManaged public var title: String?
    
    @NSManaged public var conment: String?
    
    
    @NSManaged public var doing: NSOrderedSet?
}

extension Iterm {
    /// 一个全局的 NSManagedObjectContext, 就不用把 contentView 传来传去了😁
    public static var shared: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension Iterm {
    /// 输出大概长这样 `1 天 0 小时 0 分钟 1 秒`
    var 总耗时: TimeFormater.计算后的天时分秒 {
        var resault: TimeInterval = 0

        let allDoings = self.doing?.array as? [Doing]

        if let all = allDoings {
            all.forEach { (d: Doing) in
                resault += d.持续时间
            }
        }

        return TimeFormater.计算后的天时分秒(resault)
    }
}


public struct TimeFormater {
    /// Chen Bao 专用的 Timestamp
    /// - Parameter date: 需要被 format 的 Date
    public static func ChenBaoTimestamp(date: Date = Date()) -> String {
        let d = DateFormatter()
        
        d.dateFormat = "<-yyyy-MM-dd HH:mm:ss Z EEEE"
        
        return d.string(from: date)
    }
    
    public static func 年月日时分秒(date: Date) -> String {
        let d = DateFormatter()
        
        d.dateFormat = "yyyy-MM-dd HH-mm-ss"
        
        return d.string(from: date)
    }
    
    public static func randomIn(min: Int, max: Int) -> Int {
        return Int(arc4random()) % (max - min + 1) + min
    }
    
    public static func randomString() -> String {
        let a = randomIn(min: 111, max: 999)
        
        return String(a)
    }
    
    ///  `print(时间口语化(86401))`  // `1 天 0 小时 0 分钟 1 秒`
    public static func 时间口语化(_ second: TimeInterval) -> String {
        ///
        ///     `/` 取整数
        ///     `%`取余数
        ///
        /// 1s = 1s
        /// 1m = 60s
        /// 1h = 60m = 3600s
        /// 1d = 24 h = 1,440m =  86,400s
        
        var t = Int(second)
        
        let 天: Int = t / 86400
        t = t - (天 * 86400)
        
        let 小时: Int = t / 3600
        t = t - (小时 * 3600)
        
        let 分钟: Int = (Int(t) / 60)
        t = t - (分钟 * 60)
        
        let 秒: Int = Int(t) % 60
        
        let resaut = (天 != 0 ? "\(天) 天 " : "") +
            (天 != 0 || 小时 != 0 ? "\(小时) 小时 " : "") +
            (天 != 0 || 小时 != 0 || 分钟 != 0 ? "\(分钟) 分钟 " : "") +
        "\(秒) 秒 "
        
        return resaut
    }
    
    public class 计算后的天时分秒 {
        public init(_ second: TimeInterval) {
            self.time = second
            
            var t = Int(second)
            
            self.day = t / 86400
            t = t - (self.day * 86400)
            
            self.hour = t / 3600
            t = t - (self.hour * 3600)
            
            self.minute = (Int(t) / 60)
            t = t - (self.minute * 60)
            
            self.second = Int(t) % 60
            
            self.formated = TimeFormater.时间口语化(second)
        }
        
        public let time: TimeInterval
        
        public let day: Int
        public let hour: Int
        public let minute: Int
        public let second: Int
        
        public let formated: String
    }
}
