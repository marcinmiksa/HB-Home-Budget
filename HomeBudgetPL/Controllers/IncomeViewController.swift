import UIKit
import RealmSwift

class IncomeViewController: UIViewController {
    
    let realm = try! Realm()
    var transactionObject = TransactionType()
    
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
        
        
        print(transactionObject)
        
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
    
    @IBAction func incomeButtonPressed(_ sender: Any) {
        
        transactionObject.income = 200
        
        //        let updatedTransaction = TransactionType()
        //
        //        updatedTransaction.note = transactionObject.note
        
        try! realm.write {
            realm.add(transactionObject)
        }
        
    }
    
}
