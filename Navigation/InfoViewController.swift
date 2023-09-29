//
//  InfoViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class InfoViewController: UIViewController{
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Alert", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        view.addSubview(button)
        setConstraint(forButton: button)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc private func buttonPressed() {
        let alertController = UIAlertController(title: "Some Alert", message: "Training Alert", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Do one thing", style: .default, handler: {action in print("One thing was done")}
                                               ))
        alertController.addAction(UIAlertAction(title: "Do another thing", style: .default, handler: {action in print("Another thing was done")}
                                               ))
        present(alertController,animated: true)
    }
    
    private func setConstraint(forButton: UIButton){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            forButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 250),
            forButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 10),
            forButton.heightAnchor.constraint(equalToConstant: 44),
            forButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10)
        ])
    }
    
}
