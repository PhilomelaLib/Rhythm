//
//  ContentView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//

import CoreData
import nav
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var moc: NSManagedObjectContext

    @FetchRequest(fetchRequest: Iterm.未完成())
    private var 未完成: FetchedResults<Iterm>

    @FetchRequest(fetchRequest: Iterm.已完成())
    private var 已完成: FetchedResults<Iterm>

    var body: some View {
        NavigationView {
            List {
                ForEach(self.未完成, id: \Iterm.objectID) { i in
                    Section {
                        ItermView(objectId: i.objectID, contentView: self)
                    }
                }

                if self.doned {
                    ForEach(self.已完成, id: \Iterm.objectID) { i in

                        Section {
                            ItermView(objectId: i.objectID, contentView: self)
                        }
                    }
                }
            }
            .navigationBarItems(leading:
                Button(action: { self.doned.toggle() }) { Text("show doned") },
                                trailing: self.addIterm)
            .navigationBarTitle(self.未完成.count.description)
            .listStyle(GroupedListStyle())

            .environment(\.horizontalSizeClass, .regular)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    @State private var doned: Bool = false
}

extension ContentView {
    var addIterm: some View {
//        Button(action: self.addingIterm) {
//            Text("add Iterm")
//        }
        
        sheetButton(destination: {creatingView()}) {
              Text("show")
        }
    }

    func addingIterm() {
        let i = Iterm(context: self.moc)
        i.title = "做一个 创建 新 Item 的 页面"

        i.addingDate = Date()

        try! self.moc.save()
    }
}
