//
//  NotificationManager.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 10/10/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {
    static let sharedInstance = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func configureNotification() {
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("No permission to show notification")
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
    
    func scheduleNotification(forTask task:Tasks) {
        
//        let content = UNMutableNotificationContent()
//        let categoryIdentifier = "RemindMeTasks"
//
//        content.title = task.category.stringValue()
//        content.body = task.name
//        content.sound = UNNotificationSound.default
//        content.badge = 1
//        content.categoryIdentifier = categoryIdentifier
//
//        let interval = task.interval.caluclateInterval()
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: task.startDate, repeats: <#T##Bool#>)
//        let identifier = "Local Notification"
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//
//        notificationCenter.add(request) { (error) in
//            if let error = error {
//                print("Error \(error.localizedDescription)")
//            }
//        }
//
//        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
//        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
//        let category = UNNotificationCategory(identifier: categoryIdentifier,
//                                              actions: [snoozeAction, deleteAction],
//                                              intentIdentifiers: [],
//                                              options: [])
//
//        notificationCenter.setNotificationCategories([category])
    }
    
    func deleteNotification(forTask task:Tasks) {
        
    }
}
