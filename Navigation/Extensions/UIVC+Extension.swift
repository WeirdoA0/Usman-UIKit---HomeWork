//
//  UIVC+Extension.swift
//  Navigation
//
//  Created by Руслан Усманов on 10.03.2024.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, message text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK" , style: .default ))
        self.present(alert, animated: true)
    }
}
