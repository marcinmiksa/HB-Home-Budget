import UIKit
import RealmSwift

protocol CanReceiveIncome {
    
    func dataReceivedIncome(dataIncome: String)
    
}

class IncomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    var delegateIncome : CanReceiveIncome?
    
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
        
        self.incomeTextField.delegate = self
        
        incomeTextField.placeholder = "Kwota"
        dateTextField.placeholder = "Data"
        categoryTextField.placeholder = "Kategoria"
        descriptionTextField.placeholder = "Dodatkowy opis"
        
        warningLabel.isEnabled = false
        
        data = realm.objects(Categories.self)
        category = Array(self.data)
        
        // kalendarz
        let datePicker = UIDatePicker()
        
        // ustawienie jezyka pl - kalendarz
        let loc = Locale(identifier: "pl")
        datePicker.locale = loc
        
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(IncomeViewController.dataChanged(dataPicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IncomeViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
        
        // wybor kategorii
        categoryPicker.delegate = self
        
        categoryPicker.dataSource = self
        
        categoryTextField.inputView = categoryPicker
        
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
        
        categoryTextField.text? = category[row].categoryName
        
        self.view.endEditing(false)
        
    }
    
    @IBAction func incomeButtonPressed(_ sender: Any) {
        
        let newTransaction = Transactions()
        
        let categoryResults = realm.objects(Categories.self)
        let accountResults = realm.objects(Account.self)
        let incomeTextFieldToDouble = Double(incomeTextField.text!)
        
        if incomeTextField.text == "" || incomeTextFieldToDouble == 0
            || categoryTextField.text == "" || dateTextField.text == "" {
            
            warningLabel.text = "Wprowadź wszystkie dane"
            warningLabel.isEnabled = true
            
        }
            
        else {
            
            newTransaction.income = incomeTextFieldToDouble!
            newTransaction.dataTransaction = dateTextField.text!
            newTransaction.note = descriptionTextField.text!
            
            warningLabel.text = ""
            warningLabel.isEnabled = false
            
            if let account = accountResults.first {
                
                for categoryResult in categoryResults {
                    
                    if categoryResult.categoryName == categoryTextField.text! {
                        
                        newTransaction.income = incomeTextFieldToDouble ?? 0.0
                        
                        try! realm.write {
                            if newTransaction.income != 0 && newTransaction.dataTransaction != ""
                                && categoryResult.categoryName != "" {
                                account.transactions.append(newTransaction)
                                categoryResult.categories.append(newTransaction)
                            }
                        }
                        
                    }
                    
                }
                
            }
            
            delegateIncome?.dataReceivedIncome(dataIncome: incomeTextField.text!)
            
            navigationController?.popViewController(animated: true)
            
        }
        
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
