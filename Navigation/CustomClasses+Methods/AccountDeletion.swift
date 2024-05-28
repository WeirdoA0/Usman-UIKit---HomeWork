//
//  AccountDeletion.swift
//  Navigation
//
//  Created by Руслан Усманов on 07.05.2024.
//

import Foundation
import Firebase
import StorageService


func deleteAccount(user: UserFirebase, completion: @escaping () -> Void) {
    user.user.delete(completion: { error in
        print(error?.localizedDescription as Any)
        completion()
    })

        
    }

func signOut(){
    try? Auth.auth().signOut()
}
