//
//  LoginViewDelegate.swift
//  StorageService
//
//  Created by Руслан Усманов on 14.11.2023.
//

import Foundation
public protocol LoginViewControllerDelegate {

    func singUp(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void)
    
    func checkCredentials(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void)
}
