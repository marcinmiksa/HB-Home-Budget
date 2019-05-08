import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceive {
    
    let realm = try! Realm()
    let accountObject = Account()
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let balanceValue = realm.object(ofType: Account.self, forPrimaryKey: 1)
        
        print(balanceValue!)
        
        // ustawienie wartosci poczatkowej, gdy uruchamiamy po raz pierwszy program
        balanceLabel.text = "\(balanceValue?.balance ?? 0.0)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingsSegue" {
            
            let secondVC = segue.destination as! SettingsViewController
            
            secondVC.delegate = self
            
        }
        
    }
    
    func dataReceived(data: String) {
        
        balanceLabel.text = data
        accountObject.balance = Double(data)!
        
        // funkcja pozwala na aktualizacje wartosci salda
        func updateAccountRealm(account: Account){
            
            let updatedAccount = Account()
            
            updatedAccount.id = account.id
            updatedAccount.balance = account.balance
            
            try! realm.write() {
                realm.add(updatedAccount, update: true)
            }
            
        }
        
    }
    
}
