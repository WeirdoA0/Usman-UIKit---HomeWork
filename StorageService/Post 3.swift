//
//  Post.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

public struct Post {
    public let author: String
    public let description: String
    public let image: String
    public let like: Int
    public let views: Int
    public let id: Int
    
    public init(author: String, description: String, image: String, like: Int, views: Int, id: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.like = like
        self.views = views
        self.id = id
    }
    
    
    
}

// MARK: DATA

public extension Post {

    static func make() -> [Post] {
        let text3: String = "Rockstar скоро - в начале декабря, представят первый трейлер новой GTA 6, будем следить за этим"
        let text2: String = "Какой замечательный, такой зеленый, такой хороший запах - запах природы, рекомендую всем почаще выходить на природу, полезно не только ддя здоровья тела, но и духа"
        let text: String = " От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStrore - пора начинать действовать!"
        let posts = [
            Post(author: "Нетология", description: text , image: "netologyLogo", like: 766, views: 893, id: 1 ),
            Post(author: "Любитель природы", description: text2, image: "forest", like: 150, views: 637, id: 2),
            Post(author: "Любитель игр", description: text3, image: "gta", like: 11105, views: 56742, id: 3)
            ]
        
        return posts
    }
}




 
