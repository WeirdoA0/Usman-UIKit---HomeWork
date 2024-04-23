//
//  CustomTapGesture.swift
//  Navigation
//
//  Created by Руслан Усманов on 12.03.2024.
//

import Foundation
import UIKit

class CustomTapGesture: UITapGestureRecognizer {

    var completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        super.init(target: nil, action:  #selector(action))
        addTarget(self, action: #selector(action))
    }
    
    @objc func action(){
        completion()
    }

    
}

