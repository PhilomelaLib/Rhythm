//
//  ContentView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//

import CoreData
import Introspect
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

                if self.showDone {
                    ForEach(self.已完成, id: \Iterm.objectID) { i in

                        Section {
                            ItermView(objectId: i.objectID, contentView: self)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .introspectNavigationController(customize: { (n: UINavigationController) in
                let standardAppearance = UINavigationBarAppearance()
                standardAppearance.configureWithOpaqueBackground() // 不透明背景

//                standardAppearance.configureWithTransparentBackground()
                standardAppearance.shadowImage = nil // 去掉 navigationBar 下面的阴影
                standardAppearance.shadowColor = .clear

                n.navigationBar.standardAppearance = standardAppearance

//                n.navigationBar.compactAppearance = standardAppearance

//                n.navigationBar.scrollEdgeAppearance = standardAppearance
            })

            .navigationBarItems(leading:
                Button(action: { self.showDone.toggle() }) { Text("show doned") },
                                trailing: self.addIterm)
            .navigationBarTitle(self.未完成.count.description)

            .environment(\.horizontalSizeClass, .regular)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    @State private var showDone: Bool = false
}

extension ContentView {
    var addIterm: some View {
//        Button(action: self.addingIterm) {
//            Text("add Iterm")
//        }

        sheetButton(destination: { creatingView() }) {
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

public struct sheetButton<Content: View, Destination: View>: View {
    /// - Parameters:
    ///   - destination: 被弹出的视图
    ///   - content: sheetButton 的外观
    public init(destination: @escaping () -> Destination, @ViewBuilder content: @escaping () -> Content) {
        self.destination = destination
        self.content = content
    }

    /// sheetButton 的外观
    private var content: () -> Content

    /// 被弹出的视图
    let destination: () -> Destination

    /// 用于 弹出 destination
    @State private var didSheeted: Bool = false

    /// 用于确定是否 使用 Button 来包住 content
    @State private var style: sheetButton.Style = .button

    public var body: some View {
        Group {
            if self.style == .button {
                Button(action: {
                    self.didSheeted.toggle()
                }) {
                    self.content()
                }
            } else if self.style == .none {
                self.content()
                    .onTapGesture {
                        self.didSheeted.toggle()
                    }
            } else {
                self.content()
                    .onTapGesture {
                        self.didSheeted.toggle()
                    }
            }
        }
        .sheet(isPresented: self.$didSheeted, content: self.destination)
    }

    public func sheetButtonStyle(_ style: sheetButton.Style) -> sheetButton {
        let B = self
        B.style = style
        return B
    }

    public enum Style {
        case button
        case none
    }
}
