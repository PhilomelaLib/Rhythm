//
//  Doing+CoreDataProperties.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//
//

import Foundation
import CoreData


extension Doing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doing> {
        return NSFetchRequest<Doing>(entityName: "Doing")
    }

    @NSManaged public var start: Date?
    @NSManaged public var end: Date?
    @NSManaged public var parent: Iterm?

}
