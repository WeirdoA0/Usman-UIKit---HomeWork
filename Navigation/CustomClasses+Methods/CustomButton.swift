//
//  CustomButton.swift
//  Navigation
//
//  Created by Руслан Усманов on 25.11.2023.
//

import UIKit

class CustomButton: UIButton {
    
    
    private var title: String
    private var textColor: UIColor
    private var backColor: UIColor?
    var closure: () -> Void
    private var font: UIFont?
    @objc func didTapOnBtn(){
        closure()
    }
    
    init(title: String, textColor: UIColor, backColor: UIColor?, closure: @escaping () -> Void = {}, font: UIFont = UIFont.systemFont(ofSize: 12) ) {
        self.title = title
        self.textColor = textColor
        self.backColor = backColor
        self.closure = closure
        self.font = font
        
        super.init(frame: .zero)
        
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(self.title, for: .normal)
        self.backgroundColor = backColor
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.addTarget(self, action: #selector(didTapOnBtn), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private let btn = CustomButton(title: "", textColor: .blue, backColor: .white){
    
}
