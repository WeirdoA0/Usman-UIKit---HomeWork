//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Руслан Усманов on 27.10.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "GalleryCell"
    
    // MARK: Subviews
    
    private lazy var picture: UIImageView = {
       let pic = UIImageView()
        
        pic.translatesAutoresizingMaskIntoConstraints = false
        
        return pic
    }()
    
    // MARK: LifeCycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setConstraints()
        
    }
    

    // MARK: Private
    private func addSubviews() {
        contentView.addSubview(picture)
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            picture.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            picture.topAnchor.constraint(equalTo: contentView.topAnchor),
            picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
    //MARK: Update
    internal func update(image named: String) {
        picture.image = UIImage(named: named)
    }
}
