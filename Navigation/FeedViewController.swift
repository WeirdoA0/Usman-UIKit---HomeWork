//
//  FeedViewControler.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class FeedViewController: UIViewController{
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("To post", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .white
        view.addSubview(button)
        setConstraint(forButton: button)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    }
        @objc func buttonPressed() {
            let postViewController = PostViewController()
            postViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func setConstraint(forButton: UIButton){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            forButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            forButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 10),
            forButton.heightAnchor.constraint(equalToConstant: 44),
            forButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
        ])
    }
    
}



