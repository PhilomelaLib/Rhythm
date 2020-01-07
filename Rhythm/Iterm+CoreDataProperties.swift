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
import nav
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
