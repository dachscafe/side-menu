# 概要
- オブジェクト指向な画面を作りたい時、画面が埋まりきらないサイドメニューを作りたくなる。
- でもSwiftUIのNavigation系に画面幅3/4くらいだけ開くようなViewが意外とない。
- iPadやMac用のSwiftUIだと、`NavigationSpiltView`なるものがあるが、iPhoneシリーズには対応していない、というか`NavigationStack`と同じ動き。
- NavigationStackやListの良さを活かしつつ、最もシンプルであろう方法で作成した。


# 環境
- macOS: 13.3.1
- iOS: 16.4
- XCode: 14.3

# 完成品
<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2918864/2a81d020-a68e-6452-aee1-7a7d30f98526.gif" width=300px>

# GitHub



# ソースコード
1. ContentView
    - 下記のように、`ContentView`に`ZStack`で`MenuView`をかぶせる。
    - 開閉には`@State`のBool値を使う。
    - アニメーションもつけると開閉している感が出る。
    - 左上のボタンはtoolbarを使って、ハンバーガーメニューっぽい３本線を置く。
    
    ```swift: ContentView.swift
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
    ```

1. `MenuView`は下記のようにする。
    - 開閉は`@Binding`にし、mutableな変数を引数とする。
    - 画面幅の3/4サイズのMenuを広げるため、`maxWidth`には画面幅を格納。
    - `offset()`モディファイアを使って、`isOpen`が`false`の時は、x軸方向に画面幅分だけ場外に行ってもらう。
    - `true`で帰ってくる
    - Menuが開くと、後ろは薄黒くなる。それをタップすると閉じる（ここにもアニメーション）。
    - 最下部には開発者名とか入れるとそれっぽい
    
    ```swift: MenuView.swift
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
                    /// 開発者とか入れるとそれっぽい
                    VStack {
                        Spacer()
                        Text("developed by")
                            .font(.footnote)
                        Text("Cafe")
                            .font(.footnote)
                    }
                    .foregroundColor(.secondary)
                    .padding()
                }
                /// 画面幅の1/4だけ右側を開ける
                .padding(.trailing, maxWidth/4)
                /// isOpenで、そのままの位置か、画面幅だけ右にズレるかを決める
                .offset(x: isOpen ? 0 : -maxWidth)
            }
        }
    }
    ```
