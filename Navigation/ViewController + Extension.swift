//
//  ViewController + Extension.swift
//  Navigation
//
//  Created by Руслан Усманов on 14.04.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showMessageWithAction(title: String, message: String?, actionMessage: String, completion: (() -> Void)? ) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .actionSheet)
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let action = UIAlertAction(title: actionMessage, style: .default) {_ in 
            if let completion {
                completion()
            }
        }
        [alertCancel, action].forEach({
            alert.addAction($0)
        })
        
        self.present(alert, animated: true)
    }
    
}
