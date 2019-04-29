import Foundation
import RealmSwift

class Account : Object {
    @objc dynamic var initialBalance = 0
    @objc dynamic var balance = 0
    @objc dynamic var category = ""
    
    // relacja 1 do wielu
    let incomes = List<Incomes>()
    let expenses = List<Expenses>()
}

// klase transfer rozszerzenie dodaj pozniej - sa to dane do przelewu

//class Transfer : Object {
//    @objc dynamic var date = Date()
//    @objc dynamic var note = ""
//
//    var parentTransfer = LinkingObjects(fromType: Incomes.self, property: "childIncomes")
//    var parentTransfer2 = LinkingObjects(fromType: Expenses.self, property: "childExpenses")
//
//}
