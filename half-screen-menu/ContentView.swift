//
//  ContentView.swift
//  half-screen-menu
//
//  Created by Cafe on 2023/04/24.
//

import SwiftUI

struct ContentView: View {
    /// メニューの開閉
    @State var isMenuOpen = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                Text("ContentView")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                /// isMenuOpenの変化にアニメーションをつける
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isMenuOpen.toggle()
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                    }
            }
            MenuView(isOpen: $isMenuOpen)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
