import UIKit
import RealmSwift

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
                
                // kolor zielony
                cell.textLabel?.textColor = UIColor(red: 0.1137, green: 0.8196, blue: 0.6314, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 0.1137, green: 0.8196, blue: 0.6314, alpha: 1.0)
                
            } else {
                
                cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
                cell.detailTextLabel?.numberOfLines = 3;
                
                cell.detailTextLabel?.text =
                    
                "Wydatek: \(transaction.expense) PLN \nKategoria: \(categoryNameObject?.firstObject ?? "") \nOpis: \(transaction.note)"
                
                // kolor czerwony
                cell.textLabel?.textColor = UIColor(red: 1, green: 0.4196, blue: 0.4196, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 1, green: 0.4196, blue: 0.4196, alpha: 1.0)
                
            }
            
        }
        
        return cell
        
    }
    
    func getTransactions() {
        
        let realm = try! Realm()
        
        transactions = realm.objects(Transactions.self).sorted(byKeyPath: "dataTransaction", ascending: false)
        
    }
    
}
