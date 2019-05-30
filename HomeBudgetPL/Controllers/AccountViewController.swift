import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceiveBalance, CanReceiveIncome, CanReceiveExpense {
    
    let realm = try! Realm()
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        showBalance()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingsSegue" {
            
            let secondVC = segue.destination as! SettingsViewController
            
            secondVC.delegateBalance = self
            
        }
        
        if segue.identifier == "incomeSegue" {
            
            let secondVC = segue.destination as! IncomeViewController
            
            secondVC.delegateIncome = self
            
        }
        
        if segue.identifier == "expenseSegue" {
            
            let secondVC = segue.destination as! ExpenseViewController
            
            secondVC.delegateExpense = self
            
        }
        
    }
    
    func dataReceivedBalance(dataBalance: String) {
        
        let account = Account()
        
        balanceLabel.text = dataBalance
        account.balance = Double(dataBalance)!
        
        try! realm.write() {
            realm.add(account, update: true)
        }
        
    }
    
    func dataReceivedIncome(dataIncome: String) {
        
        var tmp = 0.0
        tmp = Double(balanceLabel.text!)!
        
        let addTransations: Double = tmp + Double(dataIncome)!
        balanceLabel.text = "\(addTransations)"
        
        // print(balanceLabel.text as Any)
        
    }
    
    func dataReceivedExpense(dataExpense: String) {
        
        var tmp = 0.0
        tmp = Double(balanceLabel.text!)!
        
        let oddsTransactions: Double = tmp - Double(dataExpense)!
        balanceLabel.text = "\(oddsTransactions)"
        
        // print(balanceLabel.text as Any)
        
    }
    
    func showBalance() {
        
        let totalIncomes: Double = realm.objects(Transactions.self).sum(ofProperty: "income")
        // print("Suma przychodow: \(totalIncomes)")
        
        let totalExpenses: Double = realm.objects(Transactions.self).sum(ofProperty: "expense")
        //nprint("Suma wydatkow: \(totalExpenses)")
        
        let balanceValue = realm.object(ofType: Account.self, forPrimaryKey: 0)
        
        // print(balanceValue ?? 0.0)
        
        self.balanceLabel.text = String(format: "%.02f", (balanceValue?.balance ?? 0.0) + totalIncomes - totalExpenses)
        
    }
    
}
