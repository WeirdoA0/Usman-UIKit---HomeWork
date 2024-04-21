//
//  FeedView.swift
//  Navigation
//
//  Created by Руслан Усманов on 28.11.2023.
//

import UIKit
import StorageService

class FeedView: UIView {
    
    var delegate: FeedViewDegelegate?
    
    //MARK: StackView
    
    private lazy var btn: CustomButton = CustomButton(
        title: "New Button",
        textColor: .white,
        backColor: .purple) { [weak self] in
            self?.delegate!.push()
        }
    
    private lazy var btn1: CustomButton =  CustomButton(
        title: "New Button",
        textColor: .white,
        backColor: .purple) { [weak self] in
        self?.delegate!.push()
    }

    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(btn)
        stackView.addArrangedSubview(btn1)
        
        return stackView
    }()
    //MARK: Subviews
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .none
        
        lbl.layer.cornerRadius = 18
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    private lazy var field: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .systemGray4
        field.textColor = .black
        field.placeholder = "Print here"
        field.text = "Word"
        
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        
        return field
    }()
    private lazy var checkGuessButton: CustomButton = CustomButton(
        title: "Check",
        textColor: .white,
        backColor: .systemBlue) { [weak self] in
            print("Tap is done")
            self?.delegate?.check()
    }
        

        
        
        
        //MARK: LifeCycle
        
    init(){
        super.init(frame: .zero)
        
        addSubviews()
        setConstraintsAndSetSubviews()
        setNotifications()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: Private
    
    private func addSubviews(){
        [stackView, field, checkGuessButton, label].forEach({
            self.addSubview($0)
        })
    }
    
    
    private func setConstraintsAndSetSubviews(){
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            stackView.heightAnchor.constraint(equalToConstant: 110),
            
            checkGuessButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor,constant: 32),
            checkGuessButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -48),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 36),
            
            field.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 16),
            field.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -16),
            field.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor,constant: -10),
            field.heightAnchor.constraint(equalToConstant: 48),
            
            label.leadingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor, constant: 16),
            label.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor),
            label.widthAnchor.constraint(equalTo: checkGuessButton.heightAnchor),
            label.topAnchor.constraint(equalTo: checkGuessButton.topAnchor)
            
        ])
        
        checkGuessButton.layer.cornerRadius = 10
        checkGuessButton.clipsToBounds = true
        
        
    }
    private func setNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(actionBtn) , name: .btnEvent, object: nil)

    }
    
    
    //MARK: objc

    @objc func actionBtn(){
        if delegate!.returnBool() {
            label.backgroundColor = .green
        } else {
            label.backgroundColor = .red
        }
    }
    
    //MARK: internal
    
    internal func returnWord() -> String{
        field.text ?? ""
    }
}

extension Notification.Name {
    static let btnEvent = Notification.Name("btn")
}
