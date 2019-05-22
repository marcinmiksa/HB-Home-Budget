import UIKit
import RealmSwift

protocol CanReceive {
    
    func dataReceived(data: String)
    
}

class SettingsViewController: UIViewController {
    
    let realm = try! Realm()
    
    var delegate : CanReceive?
    
    @IBOutlet weak var initBalanceButtonView: UIButton!
    @IBOutlet weak var initBalanceTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initBalanceTextField.placeholder = "Saldo początkowe"
        
    }
    
    // przekazanie wartosci z drugiego kontrolera do pierwszego 
    @IBAction func initBalanceButtonPressed(_ sender: Any) {
        
        delegate?.dataReceived(data: initBalanceTextField.text!)
        
        // przejscie do poprzedniego kontrolera
        navigationController?.popViewController(animated: true)
        
        // usuwamy wszystkieg transakcje po ustawieniu nowego salda
        let allTransactions = realm.objects(Transactions.self)
        
        try! realm.write {
            realm.delete(allTransactions)
        }
        
    }
    
    @IBAction func addCategory(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Dodaj kategorię transakcji", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dodaj kategorię", style: .default) { (action) in
            
            try! self.realm.write {
                let newCategory = Categories()
                newCategory.categoryName = textField.text!
                self.realm.add(newCategory)
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Wprowadź kategorię"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}
