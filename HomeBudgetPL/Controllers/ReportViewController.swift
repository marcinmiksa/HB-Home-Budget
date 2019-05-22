import UIKit
import RealmSwift
import Charts

class ReportViewController: UIViewController {
    
    @IBOutlet weak var barView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var entries: [PieChartDataEntry] = []
        entries.append(PieChartDataEntry(value: 50, label: "lol"))
        
    }
    
}
