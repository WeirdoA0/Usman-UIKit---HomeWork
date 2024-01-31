//
//  CheckerService.swift
//  Navigation
//
//  Created by Руслан Усманов on 24.01.2024.
//

import FirebaseAuth


 protocol CheckerServiceProtocol {
    
    
    func checkCredentials(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void)
    
    func singUP(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void)
}

class CheckerService {
    
    func checkCredentials(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void){
        Auth.auth().signIn(withEmail: login, password: password, completion: { authResult , error in
            if let error = error {
                print("Failed login")
                completion(.failure(error))
            }
            if let authResult = authResult {
                let user = authResult.user
                completion(.success(UserFirebase(user: user)))
            }
        })
        
    }
    
    func singUp(login: String, password: String, completion: @escaping(Result<UserFirebase, Error>) -> Void){
        Auth.auth().createUser(withEmail: login, password: password, completion: { authResult , error in
            if let error = error {
                print("Failed login")
                completion(.failure(error))
            }
            if let authResult = authResult {
                let user = authResult.user
                completion(.success(UserFirebase(user: user)))
            }
        })
    }
    
    
}



