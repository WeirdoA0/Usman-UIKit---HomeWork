//
//  NoftificationService.swift
//  Navigation
//
//  Created by Руслан Усманов on 17.05.2024.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationsService {

    static let shared: LocalNotificationsService = LocalNotificationsService()
    
    private init(){
        registerCategory()
    }
    
    
    func registeForLatestUpdatesIfPossible() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.provisional, .badge, .sound], completionHandler: { [weak self] granted, error in
                guard let self else { return }
                if error != nil {
                    assertionFailure("Error in notification service")
                }
                if granted {
                    self.scheduleDailyNotification()
                }
            })
    }
    
    private func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        
        content.sound = .default
        content.title = "VK"
        content.body = NSLocalizedString("Check out the latest updates", comment: "")
        content.categoryIdentifier = "CategoryID"
        
        var date = DateComponents()
        date.hour = 19
        date.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "Daily", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print(error?.localizedDescription ?? "unknown error")
            }
        }
    }
    
    func registerCategory(){
        let center = UNUserNotificationCenter.current()
        let action = UNNotificationAction(identifier: "ActionID", title: NSLocalizedString("Some Action", comment: ""), options: .foreground)
        let category = UNNotificationCategory(identifier: "CategoryID", actions: [action], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
}
