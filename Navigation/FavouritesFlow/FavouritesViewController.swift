//
//  FavouritesViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 12.03.2024.
//

import Foundation
import UIKit
import StorageService
import CoreData

class FavoritesViewController: UIViewController {
    
    private let service: FavoriteService = FavoriteService()
    
    private var authors: [String] {
        guard let objects = fetchedResultController.fetchedObjects else { return [] }
        let array = Array(Set(objects.map {
            $0.author ?? ""
        }))
        
        return array
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemGray6
        table.register(PostTableViewCell.self, forCellReuseIdentifier: .cellReuseId)
        
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController = {
        let request = PostCoreData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: service.coreDataService.backgroundContext , sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setupNavigationItems()
        fetch()
        layout()
    }
    
    //MARK: Private
    
    private func layout(){
        view.addSubview(tableView)
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16),
            
        ])
    }
    
    private func fetch(){
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func alertBtnDidTap(){
        let alert = UIAlertController(title: NSLocalizedString("Filter by author name", comment: ""), message: nil, preferredStyle: .alert)
        alert.addTextField()
        let textField: UITextField = (alert.textFields![0])
        textField.text = authors.randomElement() ?? ""
        alert.addAction(UIAlertAction(title: NSLocalizedString("Confirm", comment: ""), style: .default, handler: { [weak self] _ in
            guard let text = textField.text else { return }
            let predicate = NSPredicate(format: "author == %@", text)
            self?.fetchedResultController.fetchRequest.predicate = predicate
            self?.fetch()
            self?.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func alertCancelBtnDidTap(){
        fetchedResultController.fetchRequest.predicate = nil
        fetch()
        self.tableView.reloadData()
    }
    
    
    private func setupNavigationItems(){
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(alertBtnDidTap))
        let button2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(alertCancelBtnDidTap))
        self.navigationItem.rightBarButtonItem = button2
        self.navigationItem.rightBarButtonItems?.append(button)
    }
    
}
    
//MARK: Extension

extension FavoritesViewController: UITableViewDelegate {
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultController.sections?.first?.numberOfObjects ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseId, for: indexPath) as? PostTableViewCell else {
            print("Failed to load cell")
            fatalError()
        }
        
        let item = fetchedResultController.object(at: indexPath).post()
        
        cell.update(model: item)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            service.deleteItem(item: fetchedResultController.object(at: indexPath))
        default:
            break
        }
    }
}

//MARK: NSFetchedResultsController

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch type{
                
            case .insert:
                guard let newIndexPath else { return }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .delete:
                guard let indexPath else { return }
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .move:
                guard let indexPath,
                      let newIndexPath else { return }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath else { return }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                return
            }
        }
    }
}


private extension String {
    static var cellReuseId = "PostCell"
}

extension FavoritesViewController: FavoriteDelegateProtocol {
    func addToFavorite(post: Post) {
        
        let items = fetchedResultController.fetchedObjects ?? []
        
        guard items.contains(where: {
            Int($0.postId) == post.id
        }) == false else {
            print("already contains this post")
            return
        }
        
        service.createNewPost(post: post)
    }
       
    

}


