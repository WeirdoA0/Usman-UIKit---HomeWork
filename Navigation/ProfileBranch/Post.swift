//
//  Post.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

struct Post {
    let author: String
    let description: String
    let image: String
    let like: Int
    let views: Int
}

// MARK: DATA

extension Post {
    internal static func make() -> [Post] {
        let posts = [
            Post(author: "Нетология. Меряем карьеру через образование.", description: text , image: "netologyLogo", like: 766, views: 893)
        
            ]
        
        return posts
    }
}




 let text: String = " От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStrore - пора начинать действовать!"
