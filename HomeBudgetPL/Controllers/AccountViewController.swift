import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceive {
    
    let realm = try! Realm()
    
    var balanceRealm = Account()
    
    @IBOutlet weak var balanceView: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let balanceText = realm.objects(Account.self)
        
        print(balanceText)
        
        balanceView.text = String(balanceText[0].balance)
        
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
            
            realm.add(balanceRealm, update: true)
            
        }
        
    }
    
}
