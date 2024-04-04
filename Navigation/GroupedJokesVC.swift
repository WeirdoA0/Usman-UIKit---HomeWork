//
//  GroupedJokesVC.swift
//  Navigation
//
//  Created by Руслан Усманов on 09.03.2024.
//

import Foundation
import UIKit

class GroupedJokesViewController: UIViewController {
    
    private var items: [RealmJoke] = []
    
    private var categories: [String]{
        Array(Set(items.map( {$0.category}))).sorted()
    }
    
    private var groupedItems: [String: [RealmJoke]] {
       return Dictionary(grouping: items, by: {
            $0.category
        })
    }
    
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

extension GroupedJokesViewController: UITableViewDelegate {
    
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("Bruh")
//        let vc = JokeListViewController()
//        vc.items = (groupedItems[categories[indexPath.row]]?.map({
//            $0.jokeText
//        })) ?? []
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

extension GroupedJokesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = JokeListViewController()
        vc.items = (groupedItems[categories[indexPath.row]]?.map({
            $0.jokeText
        })) ?? []
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = categories[indexPath.row]
        let cell =  UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = item
        cell.contentConfiguration = content
        return cell
    }

}

extension GroupedJokesViewController: Subscriber {
    func update(jokes: [RealmJoke]) {
        self.items = jokes
        tableView.reloadData()
    }
}
