//
//  FeedModelTest.swift
//  NavigationTests
//
//  Created by Руслан Усманов on 08.05.2024.
//

import XCTest
@testable import Navigation

final class FeedModelTest: XCTestCase {

    let feedModel = FeedModel(secretWord: "TestWord")
    
    func testCorrectWord(){
        XCTAssertEqual(try feedModel.check(word: "TestWord"), true)
    }
    
    func testIncorrectWord(){
        XCTAssertEqual(try feedModel.check(word: "Incorrect"), false)
    }
    func testInvalidWord(){
            XCTAssertThrowsError(try feedModel.check(word: nil))
    }
}

