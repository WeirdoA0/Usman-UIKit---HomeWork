//
//  SecureStorage.swift
//  Navigation
//
//  Created by Руслан Усманов on 04.04.2024.
//

import Foundation
import Security

class SecureStorageService {
    
    func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data ] as CFDictionary
        
        SecItemDelete(query)
        
        return SecItemAdd(query, nil)
    }
    
    func load(key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne ] as CFDictionary
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query , &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}
