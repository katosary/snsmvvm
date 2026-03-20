//
//  ContentView.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/25.
//

// このファイルは、投稿一覧を表示し、新規投稿や編集・削除を行うためのメイン画面(View)を定義します

// MARK: - View 本体

import SwiftUI

/// 投稿一覧画面。投稿の一覧表示、投稿作成シートの表示、各投稿の編集・削除を提供します
struct ContentView: View {
    /// 投稿データや画面状態(シート表示など)を管理する ViewModel
    @State var viewModel = PostViewModel()
    
    /// 画面全体のレイアウト。NavigationStack でタイトルを表示し、メインコンテンツを配置
    var body: some View {
        NavigationStack{
            content()
                .navigationTitle(Text("今日の投稿")) // 画面タイトル
                .background(Color.brown.opacity(0.5)) // 画面全体の背景色
        }
    }
}

// MARK: - サブビュー(レイアウト分割)
extension ContentView {
    /// 画面下部のフローティングボタンを重ねたメインコンテンツのコンテナ
    func content() -> some View  {
        ZStack(alignment: .bottomTrailing) { // 投稿一覧の上に右下固定の入力ボタンを重ねる
            // 投稿一覧(スクロール)
            mainView()
            // 右下の新規入力ボタン
            inputButton()
        }
    }

    /// 投稿一覧をスクロール表示する領域
    func mainView() -> some View {
        ScrollView { // 縦スクロール
            LazyVStack{ // 遅延ロードで縦方向に積む
                ForEach(viewModel.posts) { post in
                    // 個々の投稿カード
                    postView(post)
                }
            }
        }
    }

    /// 新規投稿用の入力シートを表示するフローティングボタン
    func inputButton() -> some View {
        // タップで入力シートを開く
        Button {
            viewModel.iswritingsheet = true // 入力シート表示フラグ
        } label: {
            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: 35, weight: .semibold)) // アイコンサイズ
                .foregroundStyle(.white)
                .padding(20)
                .background(Color.brown)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
        .sheet(isPresented: $viewModel.iswritingsheet) { // 新規投稿シート
            SendMessageView(viewModel: viewModel)
            .padding(20)
        }
        .padding(12) // 画面端からの余白
    }

    /// 単一の投稿を表示するカードビュー
    func postView(_ post: Post) -> some View {
        // 投稿カードの内容
        VStack{
            // ユーザー名・作成日・メニュー
            HStack{
                Text(post.user) // 投稿者
                    .frame(maxWidth: 150, alignment: .leading)
                Text(post.createdAt,style:.date) // 作成日
                    .frame(maxWidth: 150, alignment: .trailing)
                Menu {
                    // 編集メニュー
                    Button {
                        // 編集シートを表示
                        viewModel.isEditSheet = true
                    } label: {
                        Label("編集", systemImage: "pencil")
                    }
                    // 対象の投稿を削除
                    Button {
                        viewModel.deletePost(targetPost: post)
                    } label: {
                        Label("削除", systemImage: "trash")
                            .padding(8)
                            .foregroundColor(.secondary)
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            // コーヒー(国名)
            HStack {
                Text("国名：") // ラベル
                Text(post.coffeeName)
            }
            .frame(maxWidth: 300, alignment: .leading)
            // 感想本文
            HStack {
                Text("感想：") // ラベル
                Text(post.content)
            }
            .frame(maxWidth: 300, alignment: .leading)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .sheet(isPresented: $viewModel.isEditSheet) { // 編集シート
            EditSheetView(viewModel: $viewModel, post: post)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

