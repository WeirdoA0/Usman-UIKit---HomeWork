//
//  LoginInspector.swift
//  StorageService
//
//  Created by Руслан Усманов on 14.11.2023.
//

import Foundation
import UIKit
public final class LoginInspector: LoginViewControllerDelegate {

    private let service: CheckerServiceProtocol
    
    
    public func singUp(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void){
        service.singUP(login: login, password: password, completion: completion)
    }
    
    public func checkCredentials(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void){
        service.checkCredentials(login: login, password: password, completion: completion)
    }
    
    
    public init(checker: CheckerServiceProtocol){
        self.service = checker
    }
}
