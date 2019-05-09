import Foundation
import RealmSwift

class CategoryType : Object {
    
    @objc dynamic var id = 1
    @objc dynamic var categoryName = ""
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
    
    // relacja 1 do 1
    @objc dynamic var relationWithTransaction: TransactionType?
    
}
