//
//  Post.swift
//  snsmvvm
//
//  Created by katoso on 2026/02/28.
//

//Model
import Foundation

struct Post: Identifiable {
    let id = UUID()
    var user: String
    var coffeeName: String
    var content: String
    var createdAt: Date
}
