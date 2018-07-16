//
//  AppDelegate.swift
//  FastCaico
//
//  Created by Yuri on 05/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit
import CoreData
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = MeatViewController()
        let navigation = FastCaicoNavigationController(rootViewController: controller)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        NotificationHandler.shared.permissionForUse()
        VoiceShortcutsDataManager.shared.updateVoiceShortcuts(completion: nil)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        userActivity.isEligibleForPrediction = true
        if let intent = userActivity.interaction?.intent as? SelectGarnishesIntent {
            os_log("Select Intent")
            let handler = SelectGarnishesIntentHandler()
            handler.handle(intent: intent) { _ in}
            return true
        }
        return false
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FastCaico")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

