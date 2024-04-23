//
//  Error.swift
//  Navigation
//
//  Created by Руслан Усманов on 04.01.2024.
//

import UIKit

public enum AppError: Error {
     case wrongLoginAndPassword
     case failedLoadModel
     case emptyField
}

public func handleError(error: Error , inView: UIViewController) {
    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    
    
    switch error {
    case AppError.emptyField:
        print("empty")
        alert.title = "Login or Password is empty"
        inView.present(alert, animated: true)
        
    case AppError.failedLoadModel:
        break
    case AppError.wrongLoginAndPassword:
        print("wrong")
        alert.title = "Incorrect login or password"
        inView.present(alert, animated: true)
    default:
        break
    }
}
