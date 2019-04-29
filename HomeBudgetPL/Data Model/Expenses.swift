import Foundation
import RealmSwift

class Expenses : Object {
    @objc dynamic var expense = 0
    var parentExpenses = LinkingObjects(fromType: Account.self, property: "expenses")
    
    //    @objc dynamic var childExpenses: Transfer?
}
