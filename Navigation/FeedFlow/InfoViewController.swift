//
//  InfoViewController.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
import NetworkService

class InfoViewController: UIViewController{
    
     private var cachedNames: [String] = []
    
    private let netwrokService = InfoViewControllerNetworkService()
    //MARK: Subviews
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Alert", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return btn
    }()
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
    private lazy var periodLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .none
        table.translatesAutoresizingMaskIntoConstraints = false

        table.register(UITableViewCell.self , forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cachedNames = []
    }

    //MARK: Interactive
    
    @objc private func buttonPressed() {
        let alertController = UIAlertController(title: "Some Alert", message: "Training Alert", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Do one thing", style: .default, handler: {action in print("One thing was done")}
                                               ))
        alertController.addAction(UIAlertAction(title: "Do another thing", style: .default, handler: {action in print("Another thing was done")}
                                               ))
        present(alertController,animated: true)
    }
    
    //MARK: Private
    
    private func setConstraints(){

        [button, label ,periodLabel, tableView].forEach({
            view.addSubview($0)
        })
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 250),
            button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            
            label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            
            periodLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            periodLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            periodLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -16),
            tableView.topAnchor.constraint(equalTo: periodLabel.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),

        ])
    }
    private func fetch(){
        netwrokService.fetch(completion: { [weak self] text in
            DispatchQueue.main.async {
                self?.label.text = text
            }
        })
        
        netwrokService.fetchTatooine(
            handlePeriod: { [weak self]  period in
            DispatchQueue.main.async {
                self?.periodLabel.text = "Tatooine period is equal to: " + period
            }
        }, handleResident: { [weak self] name in
            self?.cachedNames.append(name)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
}

extension InfoViewController: UITableViewDelegate {
    
}

extension InfoViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .systemGray2
        if cachedNames.count - 1 >= indexPath.row {
            cell.detailTextLabel?.text = cachedNames[indexPath.row]
        }
        return cell
    }
    
    
}
