//
//  ItermView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//

import CoreData
import nav
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
        .listRowBackground(self.entity.isWorking ? Color.green : Color.clear)
        .contextMenu { self.menu }
    }
    
    @Environment(\.colorScheme) var colorscheme: ColorScheme
}

extension ItermView {
    // MARK: - some Views
    
    var headerFont: Font { .title }
    
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
                self.entity.总耗时.foregroundColor(.gray)
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
