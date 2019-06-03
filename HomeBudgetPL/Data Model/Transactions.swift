import Foundation
import RealmSwift

class Transactions : Object {
    
    @objc dynamic var idTransaction = NSUUID().uuidString
    @objc dynamic var income = 0.0
    @objc dynamic var expense = 0.0
    @objc dynamic var note = ""
    @objc dynamic var dataTransaction = Date()
    
    let parentAccount = LinkingObjects(fromType: Account.self, property: "transactions")
    
    let parentCategories = LinkingObjects(fromType: Categories.self, property: "categories")
    
    override static func primaryKey() -> String? {
        return "idTransaction"
        
    }
    
}
