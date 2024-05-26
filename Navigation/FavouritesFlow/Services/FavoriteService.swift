//
//  FavoriteService.swift
//  Navigation
//
//  Created by Руслан Усманов on 10.03.2024.
//

import Foundation
import StorageService
import UIKit

class FavoriteService {
    
    let coreDataService: CoreDataServiceProtocol = CoreDataService()
    
    private lazy var context = coreDataService.backgroundContext
    
    private(set) var currentFillter: String? = nil
    
    
//    func fetch(completion: @escaping () -> Void ) {
//        context.perform{ [weak self] in
//            guard let self else { return }
//            let request = PostCoreData.fetchRequest()
//            if let currentFillter {
//                let predicate = NSPredicate(format: "author == %@", currentFillter)
//                request.predicate = predicate
//            }
//            guard let newItems = try? context.fetch(request) else { return }
//            items = newItems
//            completion()
//        }
//    }
    
    func createNewPost(post: Post) {
        
//        guard items.contains(where: {
//            Int($0.postId) == post.id
//        }) == false else {
//            print("already contains this post")
//            return
//        }
        
        context.perform { [weak self] in
            guard let self else { return }
            
            let newPost = PostCoreData(context: context)
            newPost.image = post.image
            newPost.author = post.author
            newPost.text = post.description
            newPost.likes = Int64(post.like)
            newPost.views = Int64(post.views)
            newPost.postId = Int64(post.id)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
                assertionFailure()
            }
        }
    }
    
    func deleteItem( item: PostCoreData){
        context.perform{ [weak self] in
            guard let self else { return }
            
            context.delete(item)
            try? context.save()
        }
    }
    
    func setFilter(author: String?){
        currentFillter = author
    }
    
}
