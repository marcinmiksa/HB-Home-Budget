import UIKit
import RealmSwift

protocol CanReceiveBalance {
    
    func dataReceivedBalance(dataBalance: String)
    
}

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    var delegateBalance : CanReceiveBalance?
    
    @IBOutlet weak var initBalanceButtonView: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func initBalanceButtonPressed(_ sender: Any) {
        
        var initbalanceTextField = UITextField()
        
        let alert = UIAlertController(title: "Ustaw saldo początkowe", message: "Zmiana powoduje reset salda", preferredStyle: .alert)
        
        // zmiana koloru komunikatu w UIAlertController
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedMessage")
        
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        let action = UIAlertAction(title: "Ustaw", style: .default) { (action) in
            
            if initbalanceTextField.text != "" {
                
                // przekazanie wartosci z drugiego kontrolera do pierwszego
                self.delegateBalance?.dataReceivedBalance(dataBalance: initbalanceTextField.text!)
                
            } else {
                
                print("nie zero")
                
            }
            
            let allTransactions = self.realm.objects(Transactions.self)
            
            try! self.realm.write {
                // usuwamy wszystkieg transakcje po ustawieniu nowego salda
                self.realm.delete(allTransactions)
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Wprowadź saldo"
            initbalanceTextField = alertTextField
            
            initbalanceTextField.delegate = self
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
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
    
    //funkcja ogranicza wprowadzana wartosc do dziesietnej i tylko liczby
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            
            return true
            
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        
        if let dotIndex = newText.firstIndex(of: ".") {
            
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            
        } else {
            
            numberOfDecimalDigits = 0
            
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
        
    }
    
}
