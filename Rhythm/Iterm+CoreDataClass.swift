//
//  Iterm+CoreDataClass.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//
//

import CoreData
import Foundation
import nav

@objc(Iterm)
public class Iterm: NSManagedObject {}

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

extension Iterm {
    public static func getAllIterm() -> NSFetchRequest<Iterm> {
        let request = NSFetchRequest<Iterm>(entityName: "Iterm")

        request.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]

        return request
    }

    public static func 未完成() -> NSFetchRequest<Iterm> {
        let request = NSFetchRequest<Iterm>(entityName: "Iterm")

        request.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]
        request.predicate = NSPredicate(format: "isDoone == false")
        return request
    }

    public static func 已完成() -> NSFetchRequest<Iterm> {
        let request = NSFetchRequest<Iterm>(entityName: "Iterm")

        request.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]
        request.predicate = NSPredicate(format: "isDoone == true")
        return request
    }
}

extension Iterm {
    func doingToggle(context: NSManagedObjectContext) {
        self.没有就创建(context: context)

        if (self.doing!.lastObject as! Doing).start == nil {
            (self.doing!.lastObject as! Doing).start = Date()
            self.isWorking = true
        } else {
            (self.doing!.lastObject as! Doing).end = Date()
            self.isWorking = false
        }

        do {
            try context.save()
        } catch {
            whenDebugCatching(err: error) {
                fatalError()
            }
        }
    }

    func 没有就创建(context: NSManagedObjectContext) {
        if self.doing == nil {
            // 追加一个新的
            let d = Doing(context: context)
            d.parent = self
            self.addToDoing(d)

        } else {
            if (self.doing!.array as! [Doing]).last == nil {
                // 追加一个新的
                let d = Doing(context: context)
                d.parent = self
                self.addToDoing(d)
            } else {
                if (self.doing!.array as! [Doing]).last!.end != nil {
                    // 追加一个新的
                    let d = Doing(context: context)
                    d.parent = self
                    self.addToDoing(d)
                }
            }
        }
    }
}
