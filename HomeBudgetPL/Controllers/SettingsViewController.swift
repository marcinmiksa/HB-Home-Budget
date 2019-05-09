import UIKit
import RealmSwift

protocol CanReceive {
    
    func dataReceived(data: String)
    
}

class SettingsViewController: UIViewController {
    
    var delegate : CanReceive?
    
    @IBOutlet weak var initBalanceButtonView: UIButton!
    @IBOutlet weak var initBalanceTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // przekazanie wartosci z drugiego kontrolera do pierwszego 
    @IBAction func initBalanceButtonPressed(_ sender: Any) {
        
        delegate?.dataReceived(data: initBalanceTextField.text!)
        
    }
    
}
