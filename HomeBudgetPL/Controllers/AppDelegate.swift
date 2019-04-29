//
//  AppDelegate.swift
//  HomeBudgetPL
//
//  Created by Marcin M on 25/04/2019.
//  Copyright © 2019 Marcin M. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        // inicjalizacja bazy po migracji - I sposob
        //        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
        //        }
        //
        //        lazy var _:Realm = {
        //            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1, migrationBlock: migrationBlock)
        //            return try! Realm()
        //        }()
        
        //        // inicjalizacja bazy po migracji - II sposob
        //        let config = Realm.Configuration(
        //            schemaVersion: 2,
        //            migrationBlock: { migration, oldSchemaVersion in
        //
        //                if (oldSchemaVersion < 2) {
        //                    // Nothing to do!
        //
        //                }
        //        })
        //        Realm.Configuration.defaultConfiguration = config
        //
        //        //        let configCheck = Realm.Configuration();
        //        //        let configCheck2 = Realm.Configuration.defaultConfiguration;
        //        //        let schemaVersion = configCheck.schemaVersion
        //        //        print("Schema version \(schemaVersion) and configCheck2 \(configCheck2.schemaVersion)")
        //        let configCheck = Realm.Configuration();
        //        do {
        //            let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
        //            print("schema version \(fileUrlIs)")
        //        } catch  {
        //            print(error)
        //        }
        // sciezka do bazy
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // sciezka do bazy
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // inicjalizacja bazy danych Realm - przy zmianach w bazie trzeba niestety ja fizycznie kasowac bo sa bledy
        do {
            let realm = try Realm()
            
        } catch {
            print("Error realm \(error)")
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

