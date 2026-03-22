//
//  SendMessageView.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/28.
//

import SwiftUI

struct SendMessageView: View {
    @State var viewModel = PostViewModel() //新規作成(StateObject)       外から受け取る(ObservedObject)
    
    @Environment(\.dismiss) private var dismiss
    //    @State private var rating: Int = 0
    
    var body: some View {
        NavigationStack {
            Form{
                TextField("国名", text: $viewModel.coffeeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(12)
                TextField("感想", text: $viewModel.content, axis: .vertical)
                    .lineLimit(3)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(12)
                HStack{
                    Text("評価：")
                    ForEach(1...viewModel.maxRating, id: \.self) { number in
                        viewModel.image(for: number, rating: viewModel.rating)
                            .foregroundColor(number > viewModel.rating ? viewModel.offColor : viewModel.onColor)
                            .onTapGesture {
                                viewModel.rating = number
                            }
                            .padding(.horizontal, 4)
                    }
                }
                .padding(12)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addPost()
                        viewModel.rating = 0
                        dismiss()
                    } label: {
                        Text("投稿")
                    }
                    .padding(12)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
    }
}
