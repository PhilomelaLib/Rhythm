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
    public static func fetchRequest() -> NSFetchRequest<Iterm> {
        var a = NSFetchRequest<Iterm>(entityName: "Iterm")
        
        return NSFetchRequest<Iterm>(entityName: "Iterm")
    }
}
