import UIKit
import RealmSwift

protocol CanReceiveBalance {
    
    func dataReceivedBalance(dataBalance: String)
    
}

class SettingsViewController: UIViewController {
    
    let realm = try! Realm()
    
    var delegate : CanReceiveBalance?
    
    @IBOutlet weak var initBalanceButtonView: UIButton!
    
    @IBOutlet weak var initBalanceTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initBalanceTextField.placeholder = "Saldo początkowe"
        
    }
    
    // przekazanie wartosci z drugiego kontrolera do pierwszego
    @IBAction func initBalanceButtonPressed(_ sender: Any) {
        
        delegate?.dataReceivedBalance(dataBalance: initBalanceTextField.text!)
        
        // przejscie do poprzedniego kontrolera
        navigationController?.popViewController(animated: true)
        
        // usuwamy wszystkieg transakcje po ustawieniu nowego salda
        let allTransactions = realm.objects(Transactions.self)
        
        try! realm.write {
            realm.delete(allTransactions)
        }
        
    }
    
    @IBAction func addCategory(_ sender: Any) {
        
        var addCategorytextField = UITextField()
        
        let alert = UIAlertController(title: "Dodaj kategorię transakcji", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let action = UIAlertAction(title: "Dodaj", style: .default) { (action) in
            
            try! self.realm.write {
                let newCategory = Categories()
                newCategory.categoryName = addCategorytextField.text!
                if newCategory.categoryName != "" {
                    self.realm.add(newCategory)
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Wprowadź kategorię"
            addCategorytextField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}
