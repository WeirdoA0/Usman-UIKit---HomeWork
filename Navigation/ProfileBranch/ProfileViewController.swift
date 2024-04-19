//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
class ProfileViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        
        table.showsVerticalScrollIndicator = true
        
        table.contentInset.bottom = navigationController?.navigationBar.frame.height ?? 0
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubviews()
        setConstraints()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true

    }
    
    private func tuneView() {
        view.backgroundColor = .white
    }
    private func addSubviews() {
        view.addSubview(tableView)
    }
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    private func setTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.backgroundColor = .systemBackground
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Post")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeader")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Delegate

extension ProfileViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 250
        default:
           return  0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {


        if section == 0  {

        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeader") as? ProfileHeaderView else {
            fatalError()
        }

        header.update("Doge", "doge")

        header.parent = self
            
        return header
    }
        return nil
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

//MARK: DataSource

extension ProfileViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Post.make().count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.reuseIdentifier, for: indexPath) as? PhotosTableViewCell else {
                fatalError("Fatal Error")
            }
            
            cell.parent = self
            
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as? PostTableViewCell else {
                fatalError("Fatal Error")
            }
            
            cell.update(model: Post.make()[indexPath.row - 1])
            
            return cell
        }
    }
}
