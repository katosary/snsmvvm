//
//  EditSheetView.swift
//  snsmvvm
//
//  Created by katoso on 2026/03/16.
//

import SwiftUI

struct EditSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var viewModel: PostViewModel
    let post: Post
    
    var body : some View {
        NavigationStack {
            Form {
                TextField("国名", text: $viewModel.editingCoffee)
                TextField("感想", text: $viewModel.editingContent, axis: .vertical)
            }
            .navigationTitle("投稿を編集")
            .onAppear {
                // 画面が開いたときに、元のデータをセットする
                viewModel.editingCoffee = post.coffeeName
                viewModel.editingContent = post.content
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        // ViewModelの更新関数を呼ぶ
                        viewModel.updatePost(targetPost: post)
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
    }
}

