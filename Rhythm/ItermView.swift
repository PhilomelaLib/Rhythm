//
//  ItermView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//

import CoreData
//import nav
import SwiftUI

struct ItermView: View {
    let objectId: NSManagedObjectID
    
    let contentView: ContentView
    
    // 计算属性可以及时的显示变更
    private var entity: Iterm {
        self.contentView.moc.object(with: self.objectId) as! Iterm
    }
    
    var body: some View {
        VStack {
            self.header
            
            self.conment
        }
        
        .contextMenu { self.menu }
        
        .listRowBackground(self.entity.isWorking ? Color.green : Color.clear) // 这一行放在 .contextMenu 下面就会起作用, 放到上面就不行, 不知道为啥?
    }
    
    @Environment(\.colorScheme) var colorscheme: ColorScheme
}

extension ItermView {
    // MARK: - some Views
    
    var headerFont: Font {
        #if os(iOS)
        
        return Font.title
        
        #else
        
        return Font.body
        
        #endif
    }
    
    var header: some View {
        HStack(alignment: .center) {
            self.heart
            
            Text("\(self.entity.title ?? "")")
                .foregroundColor(self.colorscheme == .dark ? Color.white : Color.black)
            Spacer()
            
            self.startAndPause
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .font(self.headerFont)
    }
    
    var conment: some View {
        Group {
            if self.entity.conment != nil {
                HStack {
                    Text("\(self.entity.conment ?? "")")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var doings: some View {
        ForEach(self.entity.doing?.array as! [Doing], id: \Doing.start) { (d: Doing) in
            VStack {
                Text(d.start?.description ?? "none")
                d.end?.description ?? "end none"
            }
        }
    }
    
    var heart: some View {
        Image(systemName: self.entity.isDoone ? "heart.fill" : "heart")
            .foregroundColor(self.entity.isDoone ? .red : .blue)
            .onTapGesture {
                self.entity.isDoone.toggle()
                
                if self.entity.isDoone {
                    self.entity.doneDate = Date()
                } else {
                    self.entity.doneDate = nil
                }
                
                do {
                    try Iterm.shared.save()
                } catch {
                    whenDebugCatching(err: error) {
                        fatalError()
                    }
                }
            }
    }
    
    var startAndPause: some View {
        Group {
            if !self.entity.isDoone {
                Image(systemName: self.entity.isWorking ? "pause.fill" : "play.fill")
                    .onTapGesture {
                        self.entity.doingToggle(context: self.contentView.moc)
                    }
            } else {
                self.entity.总耗时.formated
                    .foregroundColor(.gray)
            }
        }
    }
}

extension ItermView {
    // MARK: - context Menu
    
    var menu: some View {
        Group {
            Button("删除") {
                Iterm.shared.delete(self.entity)
                
                do {
                    try Iterm.shared.save()
                } catch {
                    whenDebugCatching(err: error) {
                        fatalError()
                    }
                }
            }
        }
    }
}

struct adfadsfadsf: View {
    @State private var selection: Int? = nil
    
    var body: some View {
        List {
            ForEach(0...199, id: \Int.self) { i in
                
                Text(i.description)
                    .background(
                        NavigationLink(destination: Text(i.description),
                                       //                                       tag: i,
//                                       selection: self.$selection,
                                       label: { EmptyView() })
                    )
            }
        }
    }
}

// func 有(paramater: Int) { print(paramater) }
//
// func 没有(_ paramater: Int) { print(paramater) }
//
// func 调用() {
//    没有(1)
//    有(paramater: 1)
// }

func whenDebugCatching(message: String = "", err: Error, f: () -> ()) {
    #if DEBUG
    
    print("\n🔰🔰🔰🔰🔰 ERROR 🔰🔰🔰🔰🔰:\n message: \(message)\n \(err)\n")
    
    f()
    
    fatalError()
    
    #endif
}
