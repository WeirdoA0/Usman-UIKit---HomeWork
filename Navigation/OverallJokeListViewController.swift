//
//  OverallJokeListViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 08.03.2024.
//

import Foundation
import UIKit

class OverallJokeListViewController: UIViewController {
    
    private var items: [(text: String, date: Date)] = []
    
    //MARK: Subivews
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    //MARK: LifCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    //MARK: Private

    private func layout(){
        let safe = view.safeAreaLayoutGuide
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor,constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor,constant: -16),
            tableView.topAnchor.constraint(equalTo: safe.topAnchor,constant: 16),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor,constant: -16),
        ])
    }
}

    //MARK: Extensions

extension OverallJokeListViewController: UITableViewDelegate {
    
}

extension OverallJokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell =  UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = item.text
        content.secondaryText = item.date.formatted()
        cell.contentConfiguration = content
        return cell
    }

}

extension OverallJokeListViewController: Subscriber {
    func update(jokes: [RealmJoke]) {
        var newArray: [(text: String, date: Date)] = []
        jokes.forEach({
            newArray.append(($0.jokeText, $0.date))
        })
        self.items = newArray
        tableView.reloadData()
    }
}
