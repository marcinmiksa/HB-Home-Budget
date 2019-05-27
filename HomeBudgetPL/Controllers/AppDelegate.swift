import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 2.0)
        
        // sciezka do bazy
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // inicjalizacja bazy danych Realm - przy zmianach w bazie trzeba niestety ja fizycznie kasowac bo sa bledy
        do {
            _ = try Realm()
        } catch {
            print("Error realm \(error)")
        }
        
        return true
    }
    
}
