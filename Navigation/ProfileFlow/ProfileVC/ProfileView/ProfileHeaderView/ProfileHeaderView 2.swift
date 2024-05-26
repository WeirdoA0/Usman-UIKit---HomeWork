//
//  ProfileHeaderView.swift
//  Navigation

//
//  Created by Руслан Усманов on 17.09.2023.
//

import UIKit
import StorageService
class ProfileHeaderView: UITableViewHeaderFooterView{
    
    weak var parent:  UIViewController?
    private var initialCenter: CGPoint?
    
    // MARK: Subviews
    
    
    private lazy var button: CustomButton = CustomButton(title: "Show status", textColor: .white, backColor: .blue){ [weak self ] in
        self?.showButtonPressed()
        
    }
        
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let statusLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 14)
        label.textAlignment = .left
        
        return label
    }()
    
    private let changeField: UITextField = {
        let field = UITextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        

        field.backgroundColor = .systemBackground
        field.textColor = .black
        field.font = field.font?.withSize(15)
        field.placeholder = "Set status here"
        
        field.layer.cornerRadius = 12
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        
        field.addTarget(nil, action: #selector(statusTextChanged), for: .editingChanged)
        
        return field
        
    }()
    
    private let avatar: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.zPosition = 1
        
        image.clipsToBounds = true
        
        
        return image
    }()
    
    
    //MARK: LifeCycle

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        tuneView()
        addSubviews()
        setConstraints()
        tuneSubviews()
        addGestures()
        
    }
    
    // MARK: Private
    
    private func tuneView() {
        contentView.backgroundColor = .systemGray6
    }
    private func addSubviews() {
        contentView.addSubview(button)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(changeField)

        contentView.addSubview(avatar)
    }

    private func setConstraints() {
        
        

        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),

            
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),

        
            
            button.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16+40),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
        
            
            statusLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -34-40),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor,constant: -36),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
        
            
            changeField.bottomAnchor.constraint(equalTo: button.topAnchor,constant: -16),
            changeField.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant:  -36),
            changeField.heightAnchor.constraint(equalToConstant: 40),
            changeField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
     
        ])
        
    }
    
    private func  tuneSubviews(){
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
   
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        
        
        contentView.bringSubviewToFront(avatar)
    }
    
    
    private func addGestures(){
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(launchAnimation)
        )
        
        avatar.addGestureRecognizer(tap)
    }
    
    
    private func addBlackView() {
        
        let blackView : UIView = {
            let view = UIView(frame: parent!.view.frame)
           
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .black
           view.alpha = 0
           
           
           return(view)
       }()
        
       self.contentView.addSubview(blackView)
    }
    
    
    
    private func addXMarkBtn() {
        let btn = UIButton(type: .close)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.alpha = 0
        
        btn.addTarget(self, action: #selector(undoAnimation), for: .touchUpInside)
        
        contentView.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            btn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            btn.heightAnchor.constraint(equalToConstant: 50),
            btn.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }

        //MARK: objc funcs

    
    @objc func showButtonPressed() {
        let prnt = parent as! ProfileViewController
        let viewmodel = prnt.viewModel!
        
        if button.titleLabel!.text == "Show status"{
            print (viewmodel.user.status)
        } else {
            viewmodel.updateUser(
                userData: .status(changeField.text ?? ""))
            
            changeField.text = ""
            button.setTitle("Show status", for: .normal)
        }
    }
    
    @objc func statusTextChanged(){
        button.setTitle("Set status", for: .normal)
        
    }
    
    //MARK: Animation
    
    @objc func launchAnimation() {
        
        print("Tap is done")
        self.initialCenter = self.avatar.center
        
        (parent!.view.subviews.first! as! UITableView).isScrollEnabled = false
        
        (parent!.view.subviews.first! as! UITableView).cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
        
        
        addBlackView()
        let blackView = contentView.subviews.last!
        addXMarkBtn()
        let btn = contentView.subviews.last!
         
        let xScale = parent!.view.frame.width / avatar.frame.width
        
        
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            animations: {
            //1
                UIView.addKeyframe(withRelativeStartTime: 5/8, relativeDuration: 3/8, animations: {
                    btn.alpha = 1
                    
                })
            //2
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 5/8, animations: {
                    blackView.alpha = 0.6
                    
                    self.avatar.layer.cornerRadius = 0
                    self.avatar.transform = CGAffineTransform(scaleX: xScale, y: xScale)
                    self.avatar.center = self.parent!.view.center

                })
        },
        completion: {finished in
            blackView.frame = self.parent!.view.frame
            self.avatar.center = self.parent!.view.center
            blackView.alpha = 0.6
            btn.alpha = 1
        }
        )
    }
    
    
    @objc func undoAnimation() {
        print("Tap 2 is done")
        
        (parent!.view.subviews.first! as! UITableView).isScrollEnabled = true
        (parent!.view.subviews.first! as! UITableView).cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
        
        let xScale = parent!.view.frame.width / avatar.frame.width
        let numverOfSubviews = contentView.subviews.count
        
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            animations: {
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 3/8,
                    animations: {
                        self.contentView.subviews[numverOfSubviews-1].alpha = 0
                        self.contentView.subviews.last!.isUserInteractionEnabled = false
                    })
                
                UIView.addKeyframe(
                    withRelativeStartTime: 3/8,
                    relativeDuration: 5/8,
                    animations: {
                        self.avatar.transform = CGAffineTransform(scaleX: 1/xScale, y: 1/xScale)
                        self.avatar.center =   self.initialCenter!
                        self.avatar.layer.cornerRadius = 50
                        self.contentView.subviews[numverOfSubviews-2].alpha = 0
                    })
                
            },
            completion: {finished in
                self.contentView.subviews[numverOfSubviews-1].removeFromSuperview()
                self.contentView.subviews[numverOfSubviews-2].removeFromSuperview()
            }
        )
        
    }
    
    
    //MARK: Internal
    
    func update(user: User) {
        nameLabel.text = user.name
        avatar.image = user.avatar
        statusLabel.text = user.status
    }

    func setupViewModel() {
         let prnt = parent as! ProfileViewController
        prnt.viewModel?.currentUserState = update(user:)
    }
    
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}


