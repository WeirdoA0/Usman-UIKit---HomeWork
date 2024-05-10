//
//  FeedModel.swift
//  Navigation
//
//  Created by Руслан Усманов on 27.11.2023.
//

import UIKit

class FeedModel {
    private var secretWord: String
    
    init(secretWord: String = "Word") {
        self.secretWord = secretWord
    }
    
     func check(word: String?) throws -> Bool {
         guard let word else {
             throw CheckError.invalidWordError
         }
         guard !word.isEmpty else {
             throw CheckError.invalidWordError
         }
        return word == secretWord
    }
}
 enum CheckError: Error {
    case invalidWordError
}

