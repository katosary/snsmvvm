//
//  SendMessageView.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/28.
//

import SwiftUI

struct SendMessageView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var post: [Post]
    @Binding private var CoffeeName: String
    @Binding private var content: String
    init(post: Binding<[Post]>,CoffeeName:Binding<String>,content: Binding<String>) {
        self._post = post
        self._CoffeeName = CoffeeName
        self._content = content
    }

    var body: some View {
        NavigationStack {
            VStack{
                TextField("国名", text: $CoffeeName)
                TextEditor(text: $content)
                Button {
                    guard content.isEmpty == false else { return }
                    post.append(Post(user: "Anonymous",CoffeeName: CoffeeName,content: content, createdAt: Date()))
                    content = ""
                    dismiss()
                } label: {
                    Image(systemName : "paperplane")
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 12)
            .navigationTitle("投稿")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
