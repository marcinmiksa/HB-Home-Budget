import UIKit
import RealmSwift

class IncomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let realm = try! Realm()
    
    var data: Results<CategoryType>!
    var category: [CategoryType] = []
    
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
        
        data = realm.objects(CategoryType.self)
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
        
        let newTransaction = TransactionType()
        
        newTransaction.id = newTransaction.incrementID()
        
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
        
        try! realm.write {
            if newTransaction.income != 0 {
                realm.add(newTransaction)
            }
        }
        
        print(newTransaction)
        
    }
    
}
