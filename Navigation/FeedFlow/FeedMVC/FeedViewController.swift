//
//  FeedViewControler.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
import StorageService
class FeedViewController: UIViewController{
     var model: FeedModel?
    

    override func viewDidLoad() {
        lazy var feedView = FeedView()
        feedView.delegate = self
        view = feedView
        model = FeedModel()
    }
}



extension FeedViewController: FeedViewDegelegate {

    
    func returnBool() -> Bool {
        let word = (view as! FeedView).returnWord()
        let bool =  model!.check(word: word)
        return bool
    }

    func check()  {
        let word = (view as! FeedView).returnWord()
        let bool =  model!.check(
            word: word
        )
        NotificationCenter.default.post(Notification(name: .btnEvent))
        print(bool)
    }
    
    func push() {
        let postViewController = PostViewController()
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
        
    }
    
}
