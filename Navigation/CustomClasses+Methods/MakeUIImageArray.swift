//
//  MakeUIImageArray.swift
//  Navigation
//
//  Created by Руслан Усманов on 22.11.2023.
//

import UIKit
func makeUIImageArray(type: ArrayType) -> [UIImage] {
    switch type {
    case .normal:
        
        var array: [UIImage] = []
        for index in 1...20 {
            array.append(UIImage(
                named: "image" + String(index))!
            )
        }
        return array
        
    case .empty:
        var array: [UIImage] = []
        for _ in 0...20 {
            array.append(UIImage()
            )
        }
        return array
    }
}

enum ArrayType {
    case empty
    case normal

}
