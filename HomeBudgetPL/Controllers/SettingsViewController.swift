import UIKit
import RealmSwift

protocol CanReceive {
    
    func dataReceived(data: String)
    
}

class SettingsViewController: UIViewController {
    
    var delegate : CanReceive?
    
    var balanceInit = 0
    
    @IBOutlet weak var initialBalanceButtonView: UIButton!
    
    @IBOutlet weak var initialBalanceView: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func initialBalanceButtonPressed(_ sender: Any) {
        
        delegate?.dataReceived(data: initialBalanceView.text!)
        
    }
    
}
