//
//  JokeDelegate.swift
//  Navigation
//
//  Created by Руслан Усманов on 09.03.2024.
//

import Foundation

protocol Subscriber {
    func update(jokes: [RealmJoke])
}

protocol Publisher {
    func publish()
}
