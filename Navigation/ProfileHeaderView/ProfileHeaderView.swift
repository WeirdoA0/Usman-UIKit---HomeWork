//
//  ProfileHeaderView.swift
//  Navigation

//
//  Created by Руслан Усманов on 17.09.2023.
//

import UIKit
class ProfileHeaderView: UIView{
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Show status", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 4
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowOpacity = 0.7
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.masksToBounds = true
        btn.clipsToBounds = false
        return btn
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doge"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let statusLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Watching at you"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()
    
    private let changeField: UITextField = {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        

        field.backgroundColor = .white
        field.textColor = .black
        field.font = field.font?.withSize(15)
        field.placeholder = "Set status here"
        
        field.layer.cornerRadius = 12
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        
        return field
        
    }()
    
    private let avatar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "doge"))
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    func addSubviews() {
        addSubview(button)
        addSubview(avatar)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(changeField)
    }

    private func setConstraints() {
        
        
        changeField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        button.addTarget(self, action: #selector(showButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),

            
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),

        
            
            button.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16+40),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
        
            
            statusLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -34-40),
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: 0),
        
            
            changeField.bottomAnchor.constraint(equalTo: button.topAnchor,constant: -16),
            changeField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            changeField.heightAnchor.constraint(equalToConstant: 40),
            changeField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])

        
    }


    @objc func showButtonPressed() {
        if button.titleLabel!.text == "Show status"{
            print (statusLabel.text ?? "")
            print(self.bounds, self.frame)
        } else {
            statusLabel.text = changeField.text
            changeField.text = ""
            button.setTitle("Show status", for: .normal)
        }
    }
    
    @objc func statusTextChanged(){
        button.setTitle("Set status", for: .normal)
        
    }
    
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}

