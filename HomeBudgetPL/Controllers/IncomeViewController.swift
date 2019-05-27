import UIKit
import RealmSwift

protocol CanReceiveIncome {
    
    func dataReceivedIncome(dataIncome: String)
    
}

class IncomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let realm = try! Realm()
    
    var delegate1 : CanReceiveIncome?
    
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
        descriptionTextField.placeholder = "Dodatkowy opis"
        
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
        let newTransaction = Transactions()
        
        //MARK: transfery zapisuja sie tylko w pierwszej kategorii - popraw
        let categoryResults = realm.objects(Categories.self)
        let accountResults = realm.objects(Account.self)
        
        if let account = accountResults.first {
            
            if let cat = categoryResults.first {
                
                let incomeTextFieldToDouble = Double(incomeTextField.text!)
                newTransaction.income = incomeTextFieldToDouble ?? 0.0
                
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
                    
                    navigationController?.popViewController(animated: true)
                    
                }
                
                delegate1?.dataReceivedIncome(dataIncome: incomeTextField.text!)
                
                try! realm.write {
                    if newTransaction.income != 0 && newTransaction.dataTransaction != ""
                        && cat.categoryName != "" {
                        
                        account.transactions.append(newTransaction)
                        cat.categories.append(newTransaction)
                        print(newTransaction)
                    }
                    
                }
                
            }
            
        }
    }
    
}
