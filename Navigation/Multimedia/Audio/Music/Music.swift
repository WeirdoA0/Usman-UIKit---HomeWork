//
//  Music.swift
//  testMultiMeadia
//
//  Created by Руслан Усманов on 11.01.2024.
//

import Foundation


let sonne = URL(fileURLWithPath: Bundle.main.path(forResource: "Sonne", ofType: "mp3")!)
let pontiff = URL(fileURLWithPath: Bundle.main.path(forResource: "Pontiff", ofType: "mp3")!)
let showMustGoOn = URL(fileURLWithPath: Bundle.main.path(forResource: "ShowMustGoOn", ofType: "mp3")!)
let peklo = URL(fileURLWithPath: Bundle.main.path(forResource: "Peklo", ofType: "mp3")!)
let deacons = URL(fileURLWithPath: Bundle.main.path(forResource: "Deacons", ofType: "mp3")!)

 func makeURLArray() -> [URL] {
    [sonne, showMustGoOn, pontiff, peklo, deacons]
}
