import UIKit
import RealmSwift

class TransactionsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var transactions: Results<Transactions>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // transactions = realm.objects(Transactions.self).filter("income != 0 OR expense !=0").sorted(byKeyPath: "dataTransaction", ascending: false)
        transactions = realm.objects(Transactions.self).sorted(byKeyPath: "dataTransaction", ascending: false)
        
        tableView.reloadData()
        
        print(transactions ?? 0)
        
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
            
            if transaction.income != 0.0 {
                cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
                cell.detailTextLabel?.numberOfLines = 6;
                
                cell.detailTextLabel?.text =
                    
                    //MARK: popraw wyswietlanie kategorii - bez nawiasow
                "Przychód: \(transaction.income) zł \nKategoria: \(transaction.parentCategories.value(forKey: "categoryName") ?? "") \nOpis: \(transaction.note)"
                
                cell.textLabel?.textColor = UIColor(red: 0.1137, green: 0.8196, blue: 0.6314, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 0.1137, green: 0.8196, blue: 0.6314, alpha: 1.0)
                
            } else {
                cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
                cell.detailTextLabel?.numberOfLines = 6;
                
                cell.detailTextLabel?.text =
                    
                    //MARK: popraw wyswietlanie kategorii - bez nawiasow
                "Wydatek: \(transaction.expense) zł \nKategoria: \(transaction.parentCategories.value(forKey: "categoryName") ?? "") \nOpis: \(transaction.note)"
                
                cell.textLabel?.textColor = UIColor(red: 1, green: 0.4196, blue: 0.4196, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 1, green: 0.4196, blue: 0.4196, alpha: 1.0)
                
            }
            print(transaction.parentCategories)
        }
        
        return cell
        
    }
    
}
