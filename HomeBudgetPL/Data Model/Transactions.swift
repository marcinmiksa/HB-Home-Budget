import Foundation
import RealmSwift

class Transactions : Object {
    
    //@objc dynamic var account: Account? = nil
    //@objc dynamic var category: Categories? = nil
    @objc dynamic var idTransaction = NSUUID().uuidString
    @objc dynamic var income = 0.0
    @objc dynamic var expense = 0.0
    @objc dynamic var note = ""
    @objc dynamic var dataTransaction = ""
    
    //@objc dynamic var accountObject: Account?
    
    let parentAccount = LinkingObjects(fromType: Account.self, property: "transactions")
    //    var parent: Account? {
    //        return parentAccount.first
    //    }
    //    var parent: Account? {
    //        return parentAccount.first
    //    }
    //
    //    var parentCat: Categories {
    //        return self.parentCategories.first!
    //    }
    
    let parentCategories = LinkingObjects(fromType: Categories.self, property: "categories")
    
    override static func primaryKey() -> String? {
        return "idTransaction"
        
    }
    
}
