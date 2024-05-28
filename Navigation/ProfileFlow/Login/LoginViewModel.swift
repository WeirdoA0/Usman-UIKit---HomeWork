//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Руслан Усманов on 06.05.2024.
//

import Foundation
import StorageService

protocol LoginViewModelProtocol {
    var checkerService: CheckerServiceProtocol { get }
    var completion: ((Result<StorageService.UserFirebase, any Error>) -> Void)? { get set }
    
    func auth(login: String, password: String)
    func signUp(login: String, password: String)
}

class LoginViewModel: LoginViewModelProtocol {
    var completion: ((Result<StorageService.UserFirebase, any Error>) -> Void)? = nil
    
    var checkerService: StorageService.CheckerServiceProtocol
    
    init(checkerService: any StorageService.CheckerServiceProtocol) {
        self.checkerService = checkerService
    }
    
    func auth(login: String, password: String) {
        checkerService.checkCredentials(login: login, password: password, completion: completion ?? { _ in})
    }
    
    func signUp(login: String, password: String) {
        checkerService.singUP(login: login, password: password, completion: completion ?? {  _ in})
    }
    
    
}
