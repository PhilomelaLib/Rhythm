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

    @FetchRequest(fetchRequest: Iterm.getAllIterm())
    private var results: FetchedResults<Iterm>

    var body: some View {
        NavigationView {
            List {
                ForEach(self.results, id: \Iterm.objectID) { i in
                    Section {
                        ItermView(objectId: i.objectID, contentView: self)
                            .listRowBackground(Color.yellow)
                    }
                }
            }
            .navigationBarItems(trailing: self.addIterm)
            .navigationBarTitle(self.results.count.description)
            .listStyle(GroupedListStyle())

            .environment(\.horizontalSizeClass, .regular)
        }
    }

    var addIterm: some View {
        Button(action: self.addingIterm) {
            Text("add Iterm")
        }
    }

    func addingIterm() {
        let i = Iterm(context: self.moc)
        i.text = "this is text"
        i.addingDate = Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
