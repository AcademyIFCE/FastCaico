//
//  NotificationHandler.swift
//  FastCaico
//
//  Created by Yuri on 11/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHandler {
    static var shared = NotificationHandler()
    private init() {}
    
    private var notificationCenter = UNUserNotificationCenter.current()
    
    func permissionForUse() {
        notificationCenter.requestAuthorization(options: [.alert, .badge]) { (_ ,  _) in }
    }
    
    func createLocalNotificationWith(body: String, title: String, subtitle: String, identifier: String, trigger: TimeInterval) {
        self.notificationCenter.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            
            let content = UNMutableNotificationContent()
            content.threadIdentifier = identifier
            content.body = body
            content.title = title
            content.subtitle = subtitle
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: trigger, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            self.notificationCenter.add(request, withCompletionHandler: nil)
        }
    }
}
