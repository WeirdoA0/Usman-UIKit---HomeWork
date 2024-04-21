//
//  VideoViewController.swift
//  Navigation
//
//  Created by Амир on 14.01.2024.
//

import Foundation
import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    var url = ["jNQXAC9IVRw","4EPGGzeu5Ic", "7CSXifq64f4","8eIVmJiEbIc"]
    
 //MARK: Subviews
    
    private lazy var videoTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = true
        return table
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setConstaints()
        setupTableView()
    }
    //MARK: Private
    private func setConstaints(){
        view.addSubview(videoTableView)
        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            videoTableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor,constant: 16),
            videoTableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor,constant:  -16),
            videoTableView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            videoTableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor,constant: -40),
        ])
    }
    private func setupTableView(){
        videoTableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoCell")
        videoTableView.estimatedRowHeight = 60
        
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
}

extension VideoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        210
    }
}
extension VideoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        url.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "VideoCell") as? VideoTableViewCell) else {fatalError()}
        cell.update(id: url[indexPath.row])
        return cell
    }
    
    
}
