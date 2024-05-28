//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Руслан Усманов on 25.05.2024.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    private let context = LAContext()
    private var error: NSError?
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        if requsetPersmission() {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "For some reason", reply: { [weak self] bool, error in
                guard self != nil else { return }
                if let error = error  {
                    print(error.localizedDescription)
                    return
                }
                authorizationFinished(bool)
            })
        } else {
            print(error?.localizedDescription ?? "Unknown error")
        }
    }
    
    func getBiometryType(isFaceID completion :@escaping (Bool) -> Void){
        if requsetPersmission() {
            switch context.biometryType.rawValue {
            case 1:
                completion(false)
            case 2:
                completion(true)
            default:
                assertionFailure("Biometry is not supported")
            }
        }
    }
    
    private func requsetPersmission() -> Bool {
    context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
}
