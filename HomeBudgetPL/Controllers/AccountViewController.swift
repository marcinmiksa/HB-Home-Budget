import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceive {
    
    let realm = try! Realm()
    
    let balanceRealm = Account()
    
    @IBOutlet weak var balanceView: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let balanceText = realm.objects(Account.self)
        
        print(balanceText)
        
        // ustawienie wartosci poczatkowej 0.0 gdy odpalamy po raz pierwszy program - jest to wartosc domyslna
        balanceView.text = "\(balanceText.first?.balance ?? 0.0)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingsSegue" {
            
            let secondVC = segue.destination as! SettingsViewController
            
            secondVC.delegate = self
            
        }
        
    }
    
    func dataReceived(data: String) {
        
        balanceView.text = data
        
        balanceRealm.balance = Double(data)!
        
        try! realm.write {
            
            self.realm.add(balanceRealm, update: true)
            
        }
        
    }
    
}
