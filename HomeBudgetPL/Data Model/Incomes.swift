import Foundation
import RealmSwift

class Incomes : Object {
    @objc dynamic var income = 0
    var parentIncomes = LinkingObjects(fromType: Account.self, property: "incomes")
    
    // relacja 1 do 1
    //    @objc dynamic var childIncomes: Transfer?
}
