//
//  creatingView.swift
//  Rhythm
//
//  Created by 陈宝 on 2020/1/4.
//  Copyright © 2020 chenbao. All rights reserved.
//

import nav
import SwiftUI

extension String: View {
    public var body: some View {
        Text(self)
    }
}

struct creatingView: View {
    var body: some View {
        NavigationView {
            VStack {
                TextField("tilte", text: self.$title,
                          onCommit: self.done)
                    .border(Color.green)

                TextField("tilte", text: self.$conment,
                          onCommit: self.done)
                    .border(Color.green)
                Spacer()
            }
            .font(.title)

            .navigationBarTitle("create an Iterm", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    "done"
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onDisappear {
            do {
                try Iterm.shared.save()
            } catch {
                whenDebugCatching(err: error) {
                    fatalError()
                }
            }
        }
    }

    @State private var title: String = ""

    @State private var conment: String = ""

    @State private var reminber: Date? = nil

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
}

extension creatingView {
    var addIterm: some View {
        Button(action: self.addingIterm) {
            Text("add Iterm")
        }
    }
}

extension creatingView {
    // MARK: - functions

    private func done() {
        if !self.title.isEmpty {
            self.addingIterm()
        }

        self.presentationMode.wrappedValue.dismiss()
    }

    /// 添加一个 Iterm
    func addingIterm() {
        let i = Iterm(context: Iterm.shared)
        i.title = self.title

        i.conment = self.conment

        i.addingDate = Date()

        i.remember = self.reminber

        try! Iterm.shared.save()
    }
}
