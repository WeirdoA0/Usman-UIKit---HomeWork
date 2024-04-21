//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Руслан Усманов on 17.10.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    
    //MARK: Subviews
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
         
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        
        
    return label
    }()
    
    private lazy var postPicture: UIImageView = {
        
        let image = UIImageView(image: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        
        return image
    }()
    
    private lazy var text: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .systemGray
        text.numberOfLines = 0
        
        
        text.sizeToFit()


        return text
    }()
    private lazy var likesBar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var viewsBar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        
        return label
    }()

    // MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneView() {
        contentView.backgroundColor = .white
    }
    
    private func addSubviews() {
        [headerLabel, postPicture, text, likesBar, viewsBar].forEach({
            contentView.addSubview($0)
        })
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            postPicture.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            postPicture.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postPicture.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postPicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            text.topAnchor.constraint(equalTo: postPicture.bottomAnchor, constant: 16),
            text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),


            
            likesBar.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 16),
            likesBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likesBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -16),
            
            viewsBar.leadingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            viewsBar.topAnchor.constraint(equalTo: likesBar.topAnchor),
            viewsBar.bottomAnchor.constraint(equalTo: likesBar.bottomAnchor),
            viewsBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
    }
    
    // MARK: Update

    internal func update(model: Post) {
        
        
        headerLabel.text = model.author
        postPicture.image = UIImage(named: model.image)
        text.text = model.description
        likesBar.text = "Likes: " + String(model.like)
        viewsBar.text = "Views: " + String(model.views)
        
    }

}
