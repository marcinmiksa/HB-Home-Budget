import Foundation
import RealmSwift

class Account : Object {
    
    @objc dynamic var id = 0
    @objc dynamic var balance = 0.0
    
    // relacja 1 do wielu
    let transactions = List<Transactions>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
