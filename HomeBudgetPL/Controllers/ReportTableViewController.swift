import UIKit
import RealmSwift

class ReportTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var transactions: Results<TransactionType>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        transactions = realm.objects(TransactionType.self).sorted(byKeyPath: "dataTransaction", ascending: false)
        
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
            
            cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
            cell.detailTextLabel?.numberOfLines = 4;
            cell.detailTextLabel?.text =
                
                //MARK: dodaj mozliwosc wyswietlania kategorii
            "Przychód: \(transaction.income) zł \nWydatek: \(transaction.expense) zł \nKategoria: \(transaction.id) \nOpis: \(transaction.note)"
            
        }
        
        return cell
        
    }
    
}
