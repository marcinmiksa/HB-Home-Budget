import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceiveBalance, CanReceiveIncome {
    
    let realm = try! Realm()
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        showBalance()
        
        // odswieza widok
        view.setNeedsLayout()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingsSegue" {
            
            let secondVC = segue.destination as! SettingsViewController
            
            secondVC.delegate = self
            
        }
        
        if segue.identifier == "incomeSegue" {
            
            let secondVC = segue.destination as! IncomeViewController
            
            secondVC.delegate1 = self
            
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
        
        let sumTransactions: Double = tmp + Double(dataIncome)!
        balanceLabel.text = "\(sumTransactions)"
        
        print(balanceLabel.text as Any)
        
    }
    
    func showBalance() {
        
        let totalIncomes: Double = realm.objects(Transactions.self).sum(ofProperty: "income")
        
        print("Suma przychodow: \(totalIncomes)")
        
        let balanceValue = realm.object(ofType: Account.self, forPrimaryKey: 0)
        
        print(balanceValue ?? 0.0)
        self.balanceLabel.text = "\(totalIncomes + (balanceValue?.balance ?? 0.0))" 
        
    }
    
}
