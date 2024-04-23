//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModelProtocol?
    var favoriteVCDelegate: FavoriteDelegateProtocol?
    
    private var posts = Post.make()
    
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
//        startEyeTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true

    }
    
    //MARK: Private
    
    private func tuneView() {
        #if DEBUG
        view.backgroundColor = .red
        #else
        view.backgroundColor = .white
        #endif
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
    private func startEyeTimer(){
        let eyeTimer = AlertWithTimer(
            period: 5,
            title: "Take care of your eye".localizeed() ,
            text: "Long usage of phone leads to eye strain, constant eye strain may affect on your vision".localizeed()
            )
        
        eyeTimer.completion = { [weak self] in
            self?.present(eyeTimer.alertWindow, animated: true)
        }
        eyeTimer.startTimer()
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

            header.parent = self
            header.setupViewModel()
            
            header.update(user: viewModel!.user)

            
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
        return posts.count + 1
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
            
            
            cell.update(model: posts[indexPath.row - 1])
            
            let gesture = CustomTapGesture(completion: { [weak self] in
                guard let self = self else { return }
                guard indexPath.row > 0 else {
                    return
                }
                self.favoriteVCDelegate?.addToFavorite(post: self.posts[indexPath.row-1])
            })
            gesture.numberOfTapsRequired = 2 
            
            cell.addGestureRecognizer(gesture)
            
            return cell
        }
    }
}



