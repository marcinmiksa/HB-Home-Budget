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

