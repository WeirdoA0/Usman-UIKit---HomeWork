//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Руслан Усманов on 05.12.2023.
//

import Foundation
import StorageService
import UIKit

protocol ProfileViewModelProtocol {
    var user: AppUser { get set }
    var currentUserState: ((AppUser) -> Void)? { get set}
    
    func loadImage(closure: @escaping (UIImage) -> Void)
    func updateUser(userData: UserData)
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var user: StorageService.AppUser
    var currentUserState: ((AppUser) -> Void)?
    
    init(user: StorageService.AppUser) {
        self.user = user
    }
    
    func loadImage(closure: @escaping (UIImage) -> Void) {
        let image = imagePool?.first ?? UIImage()
        imagePool?.removeFirst()
        closure(image)
    }
    
    func updateUser(userData: UserData) {
        switch userData {
        case .status(let status):
            user.status = status
            currentUserState?(user)
        case .name( _ ):
            currentUserState?(user)
            break
        case .avatar( _):
            currentUserState?(user)
            break
        }
    }
    
    
}

enum UserData {
    case name(String)
    case avatar(UIImage)
    case status(String)
}



private var imagePool: [UIImage]? = makeUIImageArray(type: .normal)

