//
//  AppDelegate.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        
        let managedContext = DataController().managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        do {
            let results = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count != 0 {
                if let data = results[0].value(forKey: "buses") as! Data? {
                    if let list = NSKeyedUnarchiver.unarchiveObject(with: data) as! Array<GoEuroStruct>? {
                        listBuses = list
                    }
                }
                if let data = results[0].value(forKey: "trains") as! Data? {
                    if let list = NSKeyedUnarchiver.unarchiveObject(with: data) as! Array<GoEuroStruct>? {
                        listTrains = list
                    }
                }
                if let data = results[0].value(forKey: "flights") as! Data? {
                    if let list = NSKeyedUnarchiver.unarchiveObject(with: data) as! Array<GoEuroStruct>? {
                        listFlights = list
                    }
                }
                try managedContext.save()
            }
            else {
                let moc = DataController().managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: "Entity",
                                                        in: moc)
                let options = NSManagedObject(entity: entity!,
                                              insertInto:moc)
                try moc.save()
            }
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let managedContext = DataController().managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        do {
            let results = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count != 0 {
                if let arr = listBuses as Array<GoEuroStruct>? {
                    let data = NSKeyedArchiver.archivedData(withRootObject: arr) as NSData
                    let managedObject = results[0]
                    managedObject.setValue(data, forKey: "buses")
                }
                if let arr = listTrains as Array<GoEuroStruct>? {
                    let data = NSKeyedArchiver.archivedData(withRootObject: arr) as NSData
                    let managedObject = results[0]
                    managedObject.setValue(data, forKey: "trains")
                }
                if let arr = listFlights as Array<GoEuroStruct>? {
                    let data = NSKeyedArchiver.archivedData(withRootObject: arr) as NSData
                    let managedObject = results[0]
                    managedObject.setValue(data, forKey: "flights")
                }
                try managedContext.save()
            }
            else {
                let moc = DataController().managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: "Entity",
                                                        in: moc)
                let options = NSManagedObject(entity: entity!,
                                              insertInto:moc)
                //    options.setValue("GoEuro", forKey: "goEuro")
                try moc.save()
            }
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }


}

