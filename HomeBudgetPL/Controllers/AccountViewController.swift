import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceive {
    
    let realm = try! Realm()
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // suma przychodow
        let totalIncomes: Double = realm.objects(Transactions.self).sum(ofProperty: "income")
        
        print("Suma przychodow: \(totalIncomes)")
        
        let balanceValue = realm.object(ofType: Account.self, forPrimaryKey: 0)
        
        print(balanceValue ?? 0.0)
        
        // MARK: Brak dynamicznego sumowania - dopiero po restarcie aplikacji wskazuje poprawna wartosc
        balanceLabel.text = "\(totalIncomes + (balanceValue?.balance ?? 0.0))"
        
        // odswieza widok
        view.setNeedsLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingsSegue" {
            
            let secondVC = segue.destination as! SettingsViewController
            
            secondVC.delegate = self
            
        }
        
    }
    
    func dataReceived(data: String) {
        
        let account = Account()
        
        balanceLabel.text = data
        account.balance = Double(data)!
        
        try! realm.write() {
            realm.add(account, update: true)
        }
        
    }
    
}
