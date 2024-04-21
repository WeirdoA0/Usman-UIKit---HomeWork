//
//  FeedModel.swift
//  Navigation
//
//  Created by Руслан Усманов on 27.11.2023.
//

import UIKit
class FeedModel {
    private var secretWord: String = "Word"
     func check(word: String?) -> Bool {
         word == secretWord
    }
}


