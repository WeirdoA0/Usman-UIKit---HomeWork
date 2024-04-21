//
//  LoginFactory.swift
//  StorageService
//
//  Created by Руслан Усманов on 16.11.2023.
//

import Foundation

public protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

public struct MyLoginFactory: LoginFactory {
    public func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    public init(){}
    
}
