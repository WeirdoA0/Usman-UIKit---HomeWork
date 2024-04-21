//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Руслан Усманов on 25.10.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var parent: UIViewController?
    
    static let reuseIdentifier: String = "PhotosTableViewCell"
    
// MARK: Subviews
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(CellForPhotosTableViewCell.self, forCellWithReuseIdentifier: CellForPhotosTableViewCell.reuseIdentifier)
        
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    
    private lazy var pushButton: UIButton = {
        let btn = UIButton()
        btn.setImage(arrowImage, for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var label: UILabel = {
       let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Photos"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        lbl.sizeToFit()
        
        return lbl
    }()

    private lazy var space: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: LifeCycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setConstraints()
    }

    private func tuneView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        [collection, pushButton, label, space].forEach({
            contentView.addSubview($0)
        })
        
        }
    private func setConstraints() {
        
        let height = (contentView.frame.width - 48)/4
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            pushButton.topAnchor.constraint(equalTo: label.topAnchor),
            pushButton.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            pushButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            pushButton.widthAnchor.constraint(equalTo: pushButton.heightAnchor),
            
            collection.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collection.heightAnchor.constraint(equalToConstant: height * 1.1),
            
            space.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 12),
            space.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            space.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            space.heightAnchor.constraint(equalToConstant: 16),
            space.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }
    


    @objc func buttonPressed() {
        let galleryView = PhotosViewController()
        self.parent?.navigationController?.pushViewController(galleryView, animated: true)

    }
    
}

// MARK: Delegate

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.verticalSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (contentView.frame.width - 48)/4
        return CGSize(width: height*0.9, height: height*0.9)
    }
}

//MARK: DataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForPhotosTableViewCell.reuseIdentifier, for: indexPath) as! CellForPhotosTableViewCell
        
        let prnt = parent as! ProfileViewController
        prnt.viewModel!.loadImage(closure: { image in
            cell.update(image: image)
        })
        
        return cell
    }
}




private enum Constants {
    static let verticalSpacing: CGFloat =  8.0
    
}
