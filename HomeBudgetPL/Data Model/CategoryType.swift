import Foundation
import RealmSwift

class CategoryType : Object {
    
    @objc dynamic var id = 0
    @objc dynamic var categoryName = ""
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(CategoryType.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    // relacja 1 do wielu
    let categoryType = List<TransactionType>()

}
