//
//  CellForPhotosTableViewCell.swift
//  Navigation
//
//  Created by Руслан Усманов on 25.10.2023.
//

import UIKit

class CellForPhotosTableViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "PhotoCell"
    
    
    private enum Constants {
        static let cornerRadius: CGFloat = 6
    }
    //MARK: Subviews
    private lazy var picture: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    //MARK: LifeCycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setView()
        addSubviews()
        setConstraints()
    }
    private func setView() {
        contentView.backgroundColor = .systemGray5
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
    private func addSubviews() {
        contentView.addSubview(picture)
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            picture.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            picture.topAnchor.constraint(equalTo: contentView.topAnchor),
            picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    internal func update(image : UIImage) {
          picture.image = image
    }
}
