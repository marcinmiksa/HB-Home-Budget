import UIKit
import RealmSwift

class IncomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let realm = try! Realm()
    
    var data: Results<Categories>!
    var category: [Categories] = []
    
    var categoryPicker = UIPickerView()
    
    @IBOutlet weak var saveIncomePressed: UIBarButtonItem!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        incomeTextField.placeholder = "Kwota"
        dateTextField.placeholder = "Data"
        categoryTextField.placeholder = "Kategoria"
        descriptionTextField.placeholder = "Opis"
        
        warningLabel.isEnabled = false
        
        data = realm.objects(Categories.self)
        category = Array(self.data)
        
        // kalendarz
        let dataPicker = UIDatePicker()
        
        dataPicker.datePickerMode = .date
        
        dataPicker.addTarget(self, action: #selector(IncomeViewController.dataChanged(dataPicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IncomeViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = dataPicker
        
        // wybor kategorii
        categoryPicker.delegate = self
        
        categoryPicker.dataSource = self
        
        categoryTextField.inputView = categoryPicker
        
        view.setNeedsLayout()
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @objc func dataChanged(dataPicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        dateTextField.text = dateFormatter.string(from: dataPicker.date)
        
        view.endEditing(true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return category[row].categoryName
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return category.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        categoryTextField.text = category[row].categoryName
        self.view.endEditing(false)
        
    }
    
    @IBAction func incomeButtonPressed(_ sender: Any) {
        
        
        //let account = Account()
        let newTransaction = Transactions()
        //let cat = Categories()
        
        let incomeTextFieldToDouble = Double(incomeTextField.text!)
        
        if incomeTextField.text == "" || incomeTextFieldToDouble == 0 {
            
            warningLabel.text = "Wprowadź kwotę"
            warningLabel.isEnabled = true
            
        }
        else {
            
            newTransaction.income = incomeTextFieldToDouble!
            warningLabel.text = ""
            warningLabel.isEnabled = false
            
            navigationController?.popViewController(animated: true)
            
        }
        
        newTransaction.dataTransaction = dateTextField.text!
        newTransaction.note = descriptionTextField.text!
        
        //MARK: Popraw to?!
        //        account.transactions.append(newTransaction)
        //        cat.categories.append(newTransaction)
        //
        //                let creditCard = realm.objects(CreditCard.self).first // there's some code to get this.
        //                try! realm.write {
        //                    for purchase in purchases { // purchases = objects from a son
        //                        let newPurchase = Purchase()
        //                        newPurchase.id = purchase["Id"].intValue
        //                        newPurchase.name = purchase["name"].stringValue
        //                        newPurchase.date = purchase["date"].dateValue
        //                        realm.add(newPurchase) // <-- save the purchase object to realm
        //
        //                        creditCard.purchases.append(newPurchase)
        //                    }
        //                }
        
        //        let parentAccount = realm.objects(Account.self).first!
        //
        //        try! realm.write {
        //            for transaction in account.transactions {
        //                let newTransaction = Transactions()
        //                //newTransaction.dataTransaction = transaction[dateTextField.text!] as! String
        //                newTransaction.income = transaction["income"] as! Double
        //                newTransaction.id = transaction.incrementID()
        //                //newTransaction.note = transaction[descriptionTextField.text!] as! String
        //                //newTransaction.id = transaction.incrementID()
        //
        //                realm.add(newTransaction)
        //                parentAccount.transactions.append(newTransaction)
        //                //realm.add(account, update: true)
        //                //realm.add(cat, update: true)
        //
        //            }
        //
        //        }
        
        
        try! realm.write {
            if newTransaction.income != 0 {
                realm.add(newTransaction)
            }
        }
        
        
        print(newTransaction)
    }
    
}
