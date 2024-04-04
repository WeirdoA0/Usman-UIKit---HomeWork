//
//  Joke.swift
//  Navigation
//
//  Created by Руслан Усманов on 08.03.2024.
//

import Foundation

struct Joke: Codable {
    private let categories: [String]
    var date = Date()
    let id: String
    let value: String
    var category: String {
        categories.first ?? "No category"
    }
    
    enum CodingKeys: String, CodingKey {
        case categories
        case id
        case value
    }
    
}

