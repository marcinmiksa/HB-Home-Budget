import Foundation
import RealmSwift

class Account : Object {
    
    @objc dynamic var id = 0
    @objc dynamic var balance = 0.0
    
    // relacja 1 do wielu
    let transactions = List<Transactions>()
    //@objc dynamic var transactions: Transactions?
    //let transactions = LinkingObjects(fromType: Transactions.self, property: "accountObject")
    
//    func addTransactionToAccount(transaction : Transactions) {
//        self.transactions.append(transaction)
//
//    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
