import UIKit
import RealmSwift
import ChameleonFramework

class TransactionsTableViewController: UITableViewController {
    
    var transactions: Results<Transactions>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        getTransactions()
        
        tableView.reloadData()
        
        // print(transactions ?? 0)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let transaction = transactions?[indexPath.row] {
            
            // kategorie wyswietlaja sie jako tablica wiec musimy zrzutowac na NSArray i pobrac pierwszy element
            let categoryNameObject = transaction.parentCategories.value(forKey: "categoryName") as? NSArray
            
            if transaction.income != 0.0 {
                
                cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
                cell.detailTextLabel?.numberOfLines = 6;
                
                cell.detailTextLabel?.text =
                    
                "Przychód: \(transaction.income) PLN \nKategoria: \(categoryNameObject?.firstObject ?? "") \nOpis: \(transaction.note)"
                
                cell.textLabel?.textColor = UIColor.flatGreenDark
                cell.detailTextLabel?.textColor = UIColor.flatGreenDark
                
            } else {
                
                cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
                cell.detailTextLabel?.numberOfLines = 3;
                
                cell.detailTextLabel?.text =
                    
                "Wydatek: \(transaction.expense) PLN \nKategoria: \(categoryNameObject?.firstObject ?? "") \nOpis: \(transaction.note)"
                
                cell.textLabel?.textColor = UIColor.flatRedDark
                cell.detailTextLabel?.textColor = UIColor.flatRedDark
                
            }
            
        }
        
        return cell
        
    }
    
    func getTransactions() {
        
        let realm = try! Realm()
        
        transactions = realm.objects(Transactions.self).sorted(byKeyPath: "dataTransaction", ascending: false)
        
    }
    
}
