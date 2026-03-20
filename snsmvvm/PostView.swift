//
//  ContentView.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/25.
//



//View
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PostViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.posts) {post in
                            VStack{
                                HStack{
                                    Text(post.user)
                                        .frame(maxWidth: 150 , alignment: .leading)
                                    Text(post.createdAt,style:.date)
                                        .frame(maxWidth: 150 , alignment: .trailing)
                                    Menu {
                                        // 編集ボタン
                                        Button {
                                            
                                            viewModel.isEditSheet = true
                                        } label: {
                                            Label("編集", systemImage: "pencil")
                                        }
                                        
                                        // 削除ボタン
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
                                HStack{
                                    Text("国名：")
                                    Text(post.coffeeName)
                                }
                                .frame(maxWidth: 300,alignment: .leading)
                                HStack{
                                    Text("感想：")
                                    Text(post.content)
                                }
                                .frame(maxWidth: 300,alignment: .leading)
                            }
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(10)
                            .sheet(isPresented: $viewModel.isEditSheet){
                                EditSheetView(viewModel : viewModel,post:post)
                                
                            }

                        }
                    }
                }
                //右下の入力ページ表示ボタン
                Button {
                    viewModel.iswritingsheet = true
                } label: {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(Color.brown)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .sheet(isPresented: $viewModel.iswritingsheet){
                    SendMessageView(viewModel: viewModel)
                    .padding(20)
                }
                .padding(12)
            }
            .navigationTitle(Text("今日の投稿"))
    
            .background(Color.brown.opacity(0.5))
            
        }
    }
}


#Preview {
    ContentView()
}
