//
//  JokeListViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 09.03.2024.
//

import UIKit

class JokeListViewController: UIViewController {
    
    var items: [String] = []
    
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

extension JokeListViewController: UITableViewDelegate {
    
}

extension JokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell =  UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = item
        cell.contentConfiguration = content
        return cell
    }

}

