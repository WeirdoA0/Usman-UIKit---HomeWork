//
//  UserService.swift
//  StorageService
//
//  Created by Руслан Усманов on 08.11.2023.
//

import UIKit
public protocol UserService {
    var user: AppUser {get set}
    
    func authorizeUser(_ login: String, closure: (Result<AppUser, Error>) -> Void)

}

extension UserService {
    public func authorizeUser(_ login: String, closure: (Result<AppUser, Error>) -> Void) {
        if login == user.login {
            closure(.success(user))
        } else {
            closure(.failure(AppError.failedLoadModel))
        }
    }
    
}


public class AppUser {
    public var login: String
    public var name: String
    public var status: String
    public var avatar: UIImage
    
    init(login: String, name: String, status: String, avatar: UIImage) {
        self.login = login
        self.name = name
        self.status = status
        self.avatar = avatar
    }
}

public class CurrentUserService: UserService {
    
    public var user = dogeUser
    
    public init(){}
    }
    

public let dogeUser = AppUser(
    login: "login",
    name: "Doge",
    status: "Watching at you",
    avatar: UIImage(named: "doge")!)

public class TestUserService: UserService {
    
    public var user = developerUser
    
    public init(){}
}

public let developerUser = AppUser(
    login: "login",
    name: "support",
    status: "",
    avatar: UIImage(named: "profile")!)
