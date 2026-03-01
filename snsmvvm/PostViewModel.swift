//
//  PostViewModel.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/28.
//

//ViewModel
import Foundation
import Observation

@Observable
class PostViewModel {
    var post: [Post] = []
    var iswritingsheet = false
    var CoffeeName: String = ""
    var content: String = ""
    var inputcoffee: String = ""
    var inputcontent: String = ""
    
    func addPost() {
        let newPost = Post(user:"Anonymous",CoffeeName: inputcoffee,content: inputcontent, createdAt: Date())
        post.append(newPost)
        inputcoffee = ""
        inputcontent = ""
    }
}

