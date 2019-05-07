import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        let realm = try! Realm()
        //
        //        let balanceInitRealm = Account()
        //
        //        balanceInitRealm.balance = 0.0
        
        
        
        
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
            _ = try Realm()
            
            //            try! realm.write {
            //
            //                realm.add(balanceInitRealm, update: true)
            //
            //            }
            
        } catch {
            print("Error realm \(error)")
        }
        
        return true
        
    }
    
}

