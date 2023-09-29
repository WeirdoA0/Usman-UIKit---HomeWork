//
//  PostViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class PostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post.title
        view.backgroundColor = .systemGray4
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openInfoViewController))
    }
    @objc func openInfoViewController() {
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .formSheet
        present(infoViewController, animated: true)
    }
}
let post = Post(title: "Some Post")
