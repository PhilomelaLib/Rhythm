//
//  Iterm+CoreDataProperties.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//
//

import Foundation
import CoreData


extension Iterm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Iterm> {
        return NSFetchRequest<Iterm>(entityName: "Iterm")
    }

    @NSManaged public var addingDate: Date?
    @NSManaged public var isDoing: Bool
    @NSManaged public var reminber: Date?
    @NSManaged public var text: String?
    @NSManaged public var isDoone: Bool
    @NSManaged public var doing: NSOrderedSet?

}

// MARK: Generated accessors for doing
extension Iterm {

    @objc(insertObject:inDoingAtIndex:)
    @NSManaged public func insertIntoDoing(_ value: Doing, at idx: Int)

    @objc(removeObjectFromDoingAtIndex:)
    @NSManaged public func removeFromDoing(at idx: Int)

    @objc(insertDoing:atIndexes:)
    @NSManaged public func insertIntoDoing(_ values: [Doing], at indexes: NSIndexSet)

    @objc(removeDoingAtIndexes:)
    @NSManaged public func removeFromDoing(at indexes: NSIndexSet)

    @objc(replaceObjectInDoingAtIndex:withObject:)
    @NSManaged public func replaceDoing(at idx: Int, with value: Doing)

    @objc(replaceDoingAtIndexes:withDoing:)
    @NSManaged public func replaceDoing(at indexes: NSIndexSet, with values: [Doing])

    @objc(addDoingObject:)
    @NSManaged public func addToDoing(_ value: Doing)

    @objc(removeDoingObject:)
    @NSManaged public func removeFromDoing(_ value: Doing)

    @objc(addDoing:)
    @NSManaged public func addToDoing(_ values: NSOrderedSet)

    @objc(removeDoing:)
    @NSManaged public func removeFromDoing(_ values: NSOrderedSet)

}
