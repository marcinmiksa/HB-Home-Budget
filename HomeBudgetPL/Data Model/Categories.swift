import Foundation
import RealmSwift

class Categories : Object {
    
    @objc dynamic var idCategory = NSUUID().uuidString
    @objc dynamic var categoryName = ""
    
    // relacja 1 do wielu
    let categories = List<Transactions>()
    
    override static func primaryKey() -> String? {
        return "idCategory"
        
    }
    
}
