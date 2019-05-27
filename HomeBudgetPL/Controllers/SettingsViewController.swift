import UIKit
import RealmSwift

protocol CanReceiveBalance {
    
    func dataReceivedBalance(dataBalance: String)
    
}

class SettingsViewController: UIViewController {
    
    let realm = try! Realm()
    
    var delegate : CanReceiveBalance?
    
    @IBOutlet weak var initBalanceButtonView: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // przekazanie wartosci z drugiego kontrolera do pierwszego
    @IBAction func initBalanceButtonPressed(_ sender: Any) {
        
        var balancetextField = UITextField()
        
        let alert = UIAlertController(title: "Ustaw saldo początkowe", message: "Zmiana powoduje reset salda", preferredStyle: .alert)
        
        // zmiana koloru message w UIAlertController
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedMessage")
        
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let action = UIAlertAction(title: "Ustaw", style: .default) { (action) in
            
            self.delegate?.dataReceivedBalance(dataBalance: balancetextField.text!)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Wprowadź saldo"
            balancetextField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        // przejscie do poprzedniego kontrolera
        // navigationController?.popViewController(animated: true)
        
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
