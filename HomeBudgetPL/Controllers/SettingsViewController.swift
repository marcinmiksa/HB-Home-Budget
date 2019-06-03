import UIKit
import RealmSwift
import ChameleonFramework

protocol CanReceiveBalance {
    
    func dataReceivedBalance(dataBalance: String)
    
}

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    var initbalanceTextField = UITextField()
    
    var addCategorytextField = UITextField()
    
    var delegateBalance : CanReceiveBalance?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func initBalanceButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Ustaw saldo początkowe", message: "Zmiana powoduje reset salda oraz usuwa wszystkie kategorie!", preferredStyle: .alert)
        
        // zmiana koloru komunikatu w UIAlertController
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedMessage")
        
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        let action = UIAlertAction(title: "Ustaw", style: .default) { (action) in
            
            self.saveInitBalance()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Wprowadź saldo"
            self.initbalanceTextField = alertTextField
            
            self.initbalanceTextField.delegate = self
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveInitBalance() {
        
        let account = Account()
        
        let allTransactions = self.realm.objects(Transactions.self)
        let allCategories = self.realm.objects(Categories.self)
        
        if initbalanceTextField.text != "" {
            
            account.balance = Double((initbalanceTextField.text!))!
            
            try! self.realm.write {
                
                self.realm.add(account, update: true)
                
                // usuwamy wszystkieg transakcje oraz kategorie po ustawieniu nowego salda
                self.realm.delete(allTransactions)
                self.realm.delete(allCategories)
                
            }
            
            self.delegateBalance?.dataReceivedBalance(dataBalance: initbalanceTextField.text!)
            
        }
        
    }
    
    @IBAction func addCategoryButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Dodaj kategorię transakcji", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Anuluj", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        let action = UIAlertAction(title: "Dodaj", style: .default) { (action) in
            
            self.saveCategory()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Wprowadź kategorię"
            self.addCategorytextField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategory() {
        
        let categoryArray = Array(self.realm.objects(Categories.self).value(forKey: "categoryName") as! [String])
        
        // sprawdza czy wpisana kategoria w addCategorytextField jest w naszej tablicy kategorii
        let existCategory = categoryArray.contains(self.addCategorytextField.text!)
        
        try! self.realm.write {
            
            let newCategory = Categories()
            
            newCategory.categoryName = addCategorytextField.text!
            newCategory.categoryColor = UIColor.randomFlat.hexValue()
            
            if newCategory.categoryName != "" && existCategory == false {
                
                self.realm.add(newCategory)
                
            }
            
        }
        
    }
    
}

// rozszerzenie dla kontrolerow
extension UIViewController {
    
    // funkcja ogranicza wprowadzanie tylko wartosci dziesietnych
    @objc(textField:shouldChangeCharactersInRange:replacementString:) func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
    
    // zamiana string na date
    func convertStringtToDate(strDate: String) -> Date! {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: strDate)
        
        return date
        
    }
    
    // zamiana daty na string
    func convertDateToString(date : Date ) -> String! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: date)
        
        return date
    }
    
}
