//
//  LocalPushManager.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

// MARK: - LocalPushManager
class LocalPushManager: NSObject {

    /// Singleton
    public static let sharedInstance = LocalPushManager()
    
    /// Notification center
    public let notificationCenter = UNUserNotificationCenter.current()
}

// MARK: - Publics
extension LocalPushManager {
    
    /// Request to send push notifications
    public func requestNotification(callback: @escaping (Error?) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound]
        self.notificationCenter.requestAuthorization(options: options) { [weak self] (didAllow, error) in
            if let error = error {
                callback(error)
            } else {
                if didAllow {
                    self?.enebaleEveryDayLocalPush(pushHour: 21, pushMinute: 0, callback: callback)
                } else {
                    let customError = CustomError(title: "Local push notification not authorized", description: "User diabled local notifications", code: -1)
                    callback(customError)
                }
            }
        }
    }
    
    // Disable to send local push notifications
    public func disableEveryDayLocalPush() {
        self.notificationCenter.removePendingNotificationRequests(withIdentifiers: ["Local push notification"])
    }
}

extension LocalPushManager {
    
    /// Create every day local push notifications
    public func enebaleEveryDayLocalPush(pushHour: Int, pushMinute: Int, callback: @escaping (Error?) -> Void) {
        self.notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                let error = CustomError(title: "Local push not authorized", description: "Need to authorize local push notification", code: -1)
                callback(error)
            } else {
                let content = self.getContent()
                let dateComponents = self.getDateComponents(pushHour: pushHour, pushMinute: pushMinute)
                self.createLocalPushNotification(content: content, dateComponents: dateComponents, callback: callback)
            }
        }
    }
    
    /// Get local push notification content
    private func getContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Money keper"
        content.body = "LocalPushManagerTitle".localized()
        content.sound = .default
        
        return content
    }
    
    /// Get date components for trigger
    private func getDateComponents(pushHour: Int, pushMinute: Int) -> DateComponents {
        let calendar = Calendar.current
        let nowDate = Date()
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nowDate)
        components.hour = pushHour
        components.minute = pushMinute
        components.second = 0
        
        return components
    }
    
    /// Create local push notification
    private func createLocalPushNotification(content: UNMutableNotificationContent, dateComponents: DateComponents, callback: @escaping (Error?) -> Void) {
        let idenitifer = "Local push notification"
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: idenitifer, content: content, trigger: trigger)
        
        self.notificationCenter.add(request) { (error) in
            callback(error)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension LocalPushManager: UNUserNotificationCenterDelegate {
    
    /// When app in background
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    /// Tap on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local push notification" {
            //FIXME: Use notification if needed
        }
        
        completionHandler()
    }
}
