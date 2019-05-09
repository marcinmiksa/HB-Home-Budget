import Foundation
import RealmSwift

class TransactionType : Object {
    
    @objc dynamic var id = 1
    @objc dynamic var income = 0.0
    @objc dynamic var expense = 0.0
    @objc dynamic var note = ""
    @objc dynamic var dataTransaction = Date()
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
    
    var parentTransactionType = LinkingObjects(fromType: Account.self, property: "transactionType")
    var relationWithCategory = LinkingObjects(fromType: CategoryType.self, property: "relationWithTransaction")
    
}
