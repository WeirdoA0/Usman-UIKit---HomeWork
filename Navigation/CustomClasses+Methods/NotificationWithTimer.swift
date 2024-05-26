//
//  NotificationWithTimer.swift
//  Navigation
//
//  Created by Руслан Усманов on 03.01.2024.
//

import Foundation
import UIKit

class AlertWithTimer {
    var timer: Timer = Timer()
    var completion : (() -> Void)?
    let period: Double
    let title: String
    let text: String
    
    var alertWindow: UIAlertController = UIAlertController()
    
    init(period: Double, title: String, text: String) {
        self.period = period
        self.title = title
        self.text = text
        
        tuneAlertViewAndTimer()
        }
    
    func startTimer(){
        RunLoop.current.add(timer, forMode: .common)
    }
    func cancelTimer(){
        timer.invalidate()
    }

    private func tuneAlertViewAndTimer(){
        self.alertWindow = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.alertWindow.addAction(UIAlertAction(title: "reminder later", style: .default){ [weak self] _ in
            self?.tuneAlertViewAndTimer()
            self?.startTimer()
        }) 
        self.alertWindow.addAction(UIAlertAction(title: "thanks", style: .default){ [weak self] _ in
            self?.cancelTimer()
        })
        
        self.timer = Timer(timeInterval: period, repeats: false, block: { [weak self] _ in
            self?.completion?()
            self?.timer.invalidate()
    })
        
 }
}
