import Foundation
import RealmSwift

class Account : Object {
    
    @objc dynamic var id = 1
    @objc dynamic var balance = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // relacja 1 do wielu
    let transactionType = List<TransactionType>()
    
}
