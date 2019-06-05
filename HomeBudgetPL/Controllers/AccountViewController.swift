import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceiveBalance, CanReceiveIncome, CanReceiveExpense, CanReceiveTransaction {
    
    let realm = try! Realm()
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        createInitObject()
        
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
        
        if segue.identifier == "transactionSegue" {
            
            let secondVC = segue.destination as! TransactionsTableViewController
            
            secondVC.delegateTransaction = self
            
        }
        
    }
    
    func dataReceivedBalance(dataBalance: String) {
        
        showBalance()
        
    }
    
    func dataReceivedIncome(dataIncome: String) {
        
        showBalance()
        
    }
    
    func dataReceivedExpense(dataExpense: String) {
        
        showBalance()
        
    }
    
    func dataReceivedTransactionsTable(dataTransaction: String) {
        
        showBalance()
        
    }
    
    func showBalance() {
        
        let accountObject = realm.object(ofType: Account.self, forPrimaryKey: 0)
        
        self.balanceLabel.text = String(format: "%.02f", (accountObject?.balance ?? 0.0))
        
    }
    
    // tworzy objekt przy pierwszym uruchomieniu aplikacji - potrzebne do poprawnego zliczania salda
    func createInitObject() {
        
        let account = Account()
        
        if realm.objects(Account.self).isEmpty {
            
            account.id = 0
            account.balance = 0.00
            
            try! realm.write {
                
                realm.add(account, update: true)
                
            }
            
        }
        
    }
    
}
