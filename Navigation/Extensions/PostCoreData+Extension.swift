//
//  PostCoreData+Extension.swift
//  Navigation
//
//  Created by Руслан Усманов on 12.03.2024.
//

import StorageService

extension PostCoreData {

    func post() -> Post {
        let newPost = Post(author: self.author ?? "", description: self.text ?? "" , image: self.image ?? "", like: Int(self.likes), views: Int(self.views), id: Int(self.postId))
        return newPost
    }
}
