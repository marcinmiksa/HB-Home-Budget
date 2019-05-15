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
        let totalIncomes: Double = realm.objects(TransactionType.self).sum(ofProperty: "income")
        print(totalIncomes)
        
        let balanceValue = realm.object(ofType: Account.self, forPrimaryKey: 0)
        
        print(balanceValue ?? 0.0)
        
        // MARK: POPRAW WYSWIETLANIE ORAZ DYNAMICZNA AKTUALIZACJE WARTOSCI PRZY DODANIU PRZYCHODU
        // ustawienie wartosci poczatkowej, gdy uruchamiamy po raz pierwszy program
        balanceLabel.text = "\(balanceValue?.balance ?? 0.0) + \(totalIncomes)"
        
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
        
        // dodatkowa stala pozwala na aktualizacje wartosci salda
        //let updatedAccount = Account()
        //updatedAccount.balance = Double(data)!
        
        try! realm.write() {
            realm.add(account, update: true)
        }
        
    }
    
}
