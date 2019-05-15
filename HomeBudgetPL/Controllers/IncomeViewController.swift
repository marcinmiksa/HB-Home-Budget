import UIKit
import RealmSwift

class IncomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let realm = try! Realm()
    
    // var categories = CategoryType()
    
    //var categoryObject = [Category]()
    
    var categoryPicker = UIPickerView()
    
    let category = ["Zdrowie", "Hobby", "Rachunki"]
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        //view.setNeedsLayout()
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @objc func dataChanged(dataPicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        dateTextField.text = dateFormatter.string(from: dataPicker.date)
        
        view.endEditing(true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return category[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return category.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        categoryTextField.text = category[row]
        self.view.endEditing(false)
        
    }
    
    @IBAction func incomeButtonPressed(_ sender: Any) {
        
        //var transactions = [TransactionType]()
        let newTransaction = TransactionType()
        //let updatedTransaction = TransactionType()
        
        newTransaction.id = newTransaction.incrementID()
        
        let incomeTextFieldToDouble = Double(incomeTextField.text!)
        newTransaction.income = incomeTextFieldToDouble!
        //updatedTransaction.income = newTransaction.income
        
        newTransaction.dataTransaction = dateTextField.text!
        // updatedTransaction.dataTransaction = newTransaction.dataTransaction
        
        newTransaction.note = descriptionTextField.text!
        //updatedTransaction.note = newTransaction.note
        
        try! realm.write {
            //transactions.append(newTransaction)
            realm.add(newTransaction)
        }
        
        print(newTransaction)

    }
    
}
