//
//  String+Extension.swift
//  Navigation
//
//  Created by Руслан Усманов on 23.04.2024.
//

import Foundation

extension String {
    func localizeed() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
