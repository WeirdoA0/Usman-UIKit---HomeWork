//
//  UiColor+Extension.swift
//  Navigation
//
//  Created by Руслан Усманов on 24.04.2024.
//

import Foundation
import UIKit

extension UIColor {
    static let  customViewBackGroundColor = UIColor(dynamicProvider: { traitCollection in
        let darkColor = UIColor.systemGray
        let otherColor = UIColor.systemGray6
        return(traitCollection.userInterfaceStyle == .dark ?  darkColor :  otherColor)
    })
    static let  customControllerBackGroundColor = UIColor(dynamicProvider: { traitCollection in
        let darkColor = UIColor.black
        let otherColor = UIColor.white
        return(traitCollection.userInterfaceStyle == .dark ?  darkColor :  otherColor)
    })
    static let  customTintColor = UIColor(dynamicProvider: { traitCollection in
        let darkColor = UIColor.white
        let otherColor = UIColor.black
        return(traitCollection.userInterfaceStyle == .dark ?  darkColor :  otherColor)
    })
    static let  customImageBackGrounColor = UIColor(dynamicProvider: { traitCollection in
        let darkColor = UIColor.black
        let otherColor = UIColor.white
        return(traitCollection.userInterfaceStyle == .dark ?  darkColor :  otherColor)
    })
}
                                    
