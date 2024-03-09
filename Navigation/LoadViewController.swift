//
//  LoadViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
import RealmSwift

class LoadViewController: UIViewController {
    
    private var service: NetworkService = NetworkService()
    
    private var cachedJokes: [RealmJoke] = []
    
    var subscribers: [Subscriber]?
    
    private lazy var btn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Load Joke", for: .normal)
        btn.backgroundColor = .systemPurple
        btn.addTarget(self, action: #selector(requestJokeBtnPressed), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        
        let realm = try! Realm()
        try! realm.write({
            realm.deleteAll()
        })
        
    }
    
    
    private func layout(){
        view.addSubview(btn)
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            btn.widthAnchor.constraint(equalToConstant: 200),
            btn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func requestJokeBtnPressed() {
        service.loadJoke()
        service.fetch(completion: { [weak self] jokes in
            self?.cachedJokes = jokes
        })
        publish()
    }
}

extension LoadViewController: Publisher {
    func publish() {
        subscribers?.forEach({
            $0.update(jokes: cachedJokes)
        })
    }
}
