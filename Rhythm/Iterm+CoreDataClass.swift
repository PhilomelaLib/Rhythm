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

@objc(Iterm)
public class Iterm: NSManagedObject {}

extension Iterm {
    public static func getAllIterm() -> NSFetchRequest<Iterm> {
        let request = NSFetchRequest<Iterm>(entityName: "Iterm")

        request.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]

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
    }

//    var isWorking: Bool {
//        if self.doing != nil {
//            if (self.doing!.array as! [Doing]).last != nil {
//                if (self.doing!.array as! [Doing]).last!.end != nil {
//                    return true
//                }
//            }
//        }
//
//        return false
//    }

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
