//
//  RealmJoke.swift
//  Navigation
//
//  Created by Руслан Усманов on 08.03.2024.
//

import Foundation
import RealmSwift

class RealmJoke: Object {
    @Persisted var category: String
    @Persisted var jokeText: String
    @Persisted var date: Date
    @Persisted var id: String
    
    convenience init(joke: Joke){
        self.init()
        jokeText = joke.value
        date = joke.date
        id = joke.id
        category = joke.category
    }
}


