import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceiveBalance, CanReceiveIncome, CanReceiveExpense {
    
    let realm = try! Realm()
    
    let account = Account()
    
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
        
        balanceLabel.text = dataBalance
        account.balance = Double(dataBalance)!
        
        saveBalance()
        
    }
    
    func saveBalance() {
        
        try! self.realm.write() {
            
            // MARK: problem z ponownym ustawieniem salda poczatkowego 
            realm.add(self.account, update: true)
            
        }
        
    }
    
    func dataReceivedIncome(dataIncome: String) {
        
        var tmp = 0.0
        tmp = Double(balanceLabel.text!)!
        
        let addTransations: Double = tmp + Double(dataIncome)!
        balanceLabel.text = "\(addTransations)"
        
    }
    
    func dataReceivedExpense(dataExpense: String) {
        
        var tmp = 0.0
        tmp = Double(balanceLabel.text!)!
        
        let oddsTransactions: Double = tmp - Double(dataExpense)!
        balanceLabel.text = "\(oddsTransactions)"
        
    }
    
    func showBalance() {
        
        let totalIncomes: Double = realm.objects(Transactions.self).sum(ofProperty: "income")
        let totalExpenses: Double = realm.objects(Transactions.self).sum(ofProperty: "expense")
        let accountObject = realm.object(ofType: Account.self, forPrimaryKey: 0)
        
        // print(accountObject ?? 0.0)
        
        self.balanceLabel.text = String(format: "%.02f", (accountObject?.balance ?? 0.0) + totalIncomes - totalExpenses)
        
    }
    
}
