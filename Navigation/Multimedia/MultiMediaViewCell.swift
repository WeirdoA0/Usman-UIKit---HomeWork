//
//  MultiMediaViewCell.swift
//  Navigation
//
//  Created by Амир on 14.01.2024.
//

import UIKit

class MultimediaCollectionViewCel: UICollectionViewCell {

    static let identifier: String = "MediaCell"
    
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
    internal func update(image UIImage: UIImage) {
        picture.image = UIImage
    }
}
