//
//  ItermView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//

import CoreData
import SwiftUI

struct ItermView: View {
    let objectId: NSManagedObjectID
    
    let contentView: ContentView
    
    // 计算属性可以及时的显示变更
    private var entity: Iterm {
        self.contentView.moc.object(with: self.objectId) as! Iterm
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.heart
            
            self.text
            
            Spacer()
            
            self.startAndPause
        }
        .frame(alignment: .center)
    }
    
    var text: some View {
        VStack(alignment: .leading) {
            Text("\(self.entity.text ?? "")")
            Text(self.entity.addingDate?.description ?? "")
            ForEach(self.entity.doing?.array as! [Doing], id: \Doing.start){ d in
                Text("Doing")
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
        Image(systemName: self.entity.isWorking ? "pause.fill" : "play.fill")
            .onTapGesture {
                self.entity.doingToggle(context: self.contentView.moc)
            }
    }
}
