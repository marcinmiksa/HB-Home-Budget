import UIKit
import RealmSwift

class ReportTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var transactions: Results<TransactionType>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        transactions = realm.objects(TransactionType.self)
        
        tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let transaction = transactions?[indexPath.row] {
            
            cell.textLabel?.text = String(transaction.income)
            //cell.detailTextLabel?.text = transaction.note
            
            print("cell: \(cell)")
        }
        
        return cell
    }
    
}
