//
//  ContentView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/3.
//  Copyright © 2020 chenbao. All rights reserved.
//

import nav
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var moc: NSManagedObjectContext
    
    @State private var name: Bool = false
    var body: some View {
        ScrollView {
            HStack {
                self.heart
                
                Button(action: {
                    self.name.toggle()
                }) {
                    Text("Hello,      World!")
                }
            }
            .modifier(圆角单色背景卡(color: .yellow))
            
            .padding()
        }
    }
    
    var heart: some View {
        Image(systemName: name ? "heart.fill" : "heart")
            .foregroundColor(name ? .red : .blue)
    }
    
    var addIterm: some View {
        Button(action: {}) {
            Text("add Iterm")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
