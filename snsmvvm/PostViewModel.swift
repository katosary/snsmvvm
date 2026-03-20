//
//  PostViewModel.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/28.
//

//ViewModel
import Foundation
import Observation
import Combine

@Observable
class PostViewModel : ObservableObject {
    var posts: [Post] = []//SendMessageViewで入力された内容を保存している配列。　postsはその配列の名前
    var coffeeName: String = ""
    var content: String = ""
    var inputcoffee: String = ""
    var inputcontent: String = ""
    var editingCoffee: String = ""
    var editingContent: String = ""
    var iswritingsheet = false
    var isEditSheet: Bool = false
    var rating: Int = 0
    var maxRating = 5
    
    //投稿追加
    func addPost() {
        let newPost = Post(user:"Anonymous",coffeeName:coffeeName,content: content, createdAt: Date())
        posts.append(newPost)
        coffeeName = ""
        content = ""
    }
    
    //編集ボタン
    func updatePost(targetPost: Post) {
        if let id = posts.firstIndex(where: { $0.id == targetPost.id }) {
            // その場所の内容を、保存しておいた editingText で上書きする
            posts[id].coffeeName = self.editingCoffee
            posts[id].content = self.editingContent
            self.isEditSheet = false
        }
    }
    
    //削除ボタン
    func deletePost(targetPost: Post) {
        posts.removeAll {$0.id == targetPost.id }
    }
}

//removeAll は「条件に合うものを全部消す」という命令
//firstIndex(where:) は「条件に合うものがどこ（何番目）にあるか教えて」という命令

