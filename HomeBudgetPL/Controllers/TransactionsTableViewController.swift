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
            
            cell.textLabel?.text = "Data: \(transaction.dataTransaction)"
            cell.detailTextLabel?.numberOfLines = 6;
            cell.detailTextLabel?.text =
                
                //MARK: popraw wyswietlanie kategorii - bez nawiasow
            "Przychód: \(transaction.income) zł \nWydatek: \(transaction.expense) zł \nKategoria: \(transaction.parentCategories.value(forKey: "categoryName") ?? "") \nOpis: \(transaction.note)"
            
            print(transaction.parentCategories)
        }
        
        return cell
        
    }
    
}
