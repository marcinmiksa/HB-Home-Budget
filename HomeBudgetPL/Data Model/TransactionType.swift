import Foundation
import RealmSwift

class TransactionType : Object {
    
    @objc dynamic var id = 0
    @objc dynamic var income = 0.0
    @objc dynamic var expense = 0.0
    @objc dynamic var note = ""
    @objc dynamic var dataTransaction = ""
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(TransactionType.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    var parentTransactionType = LinkingObjects(fromType: Account.self, property: "transactionType")
    var relationWithCategory = LinkingObjects(fromType: CategoryType.self, property: "relationWithTransaction")
    
}
