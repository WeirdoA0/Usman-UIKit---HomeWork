//
//  LoginViewDelegate.swift
//  NavigationTests
//
//  Created by Руслан Усманов on 06.05.2024.
//

import XCTest
import StorageService
import Foundation
@testable import Navigation

final class loginViewDelegateTest: XCTestCase {

    let delegate  = MyLoginFactory().makeLoginInspector()
    
    func testAuth() throws {
        let FailureExpectation = expectation(description: "Auth Failed")
        let SuccesExpectation = expectation(description: "Auth Succed")
        
        delegate.checkCredentials(login: "login@gmail.com", password: "qwert", completion: {  result in
            switch result {
            case .success( _):
                break
            case .failure( _):
                FailureExpectation.fulfill()
            }
        })
        
         delegate.checkCredentials(login: "login@gmail.com", password: "qwerty", completion: {  result in
            switch result {
            case .success(let user):
                print(user.user.uid)
                if user.user.uid ==  "v7p1z5s3MVZCOnzqBs9XWGlYQNZ2" {
                    SuccesExpectation.fulfill()
                }
            case .failure( _):
            break
            }
        })
        waitForExpectations(timeout: 2)
        }
    
    func testSignUp() throws {

        let signUpExpectation = expectation(description: "Sign up")
        let invalidSignUpExpectation = expectation(description: "Invalid Sign up")
        let deletionExpectation = expectation(description: "Deleted")

        signOut()
        
        //test Creating New Account , expectiong success
        delegate.singUp(login: "testUser@mail.com", password: "password", completion: { result in
            switch result {
            case .success(let user ):
                signUpExpectation.fulfill()
                
                //deleting account
                deleteAccount(user: user) {
                    deletionExpectation.fulfill()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        })

        //testing signUp old account , expectiong failure
        delegate.singUp(login: "login@gmail.com", password: "qwerty", completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                invalidSignUpExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 2)
    }
}
