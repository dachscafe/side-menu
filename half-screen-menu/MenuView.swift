//
//  MenuView.swift
//  half-screen-menu
//
//  Created by Cafe on 2023/04/24.
//

import SwiftUI

struct MenuView: View {
    
    /// メニュー開閉
    @Binding var isOpen: Bool
    /// iPhoneの幅
    private let maxWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            /// isOpenで背景が透明な黒になる
            /// この黒をタップすると閉じる
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(isOpen ? 0.7 : 0)
                .onTapGesture {
                    /// isOpenの変化にアニメーションをつける
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isOpen.toggle()
                    }
                }
            ZStack {
                List {
                    /// 注意：増やしすぎて縦スクロールになると使いづらくなる
                    Section {
                        /// ここをNavigationLinkにするとそれっぽい
                        HStack {
                            Image(systemName: "gearshape")
                            Text("設定")
                        }
                        HStack {
                            Image(systemName: "info.circle")
                            Text("アプリケーション情報")
                        }
                    }
                }
                VStack {
                    Spacer()
                    Text("developed by")
                        .font(.footnote)
                    Text("Cafe")
                        .font(.footnote)

                }
                .foregroundColor(.secondary)
            }
            /// 画面幅の1/4だけ右側を開ける
            .padding(.trailing, maxWidth/4)
            /// isOpenで、そのままの位置か、画面幅だけ右にズレるかを決める
            .offset(x: isOpen ? 0 : -maxWidth)
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isOpen: .constant(true))
    }
}

