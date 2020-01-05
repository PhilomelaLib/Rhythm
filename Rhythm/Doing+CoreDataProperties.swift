//
//  Doing+CoreDataProperties.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//
//

import CoreData
import Foundation

extension Doing {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doing> {
        return NSFetchRequest<Doing>(entityName: "Doing")
    }

    @NSManaged public var start: Date?
    @NSManaged public var end: Date?
    @NSManaged public var parent: Iterm?
}

extension Doing {
    var 持续时间: TimeInterval {
        if let start = self.start {
            if let end = self.end {
                return start.distance(to: end)
            }
        }

        return 0
    }
}
