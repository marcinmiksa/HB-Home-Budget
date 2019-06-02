import UIKit
import RealmSwift
import Charts
import ChartsRealm
import ChameleonFramework

class ChartViewController: UIViewController {
    
    @IBOutlet weak var incomesPieChart: PieChartView!
    @IBOutlet weak var expensesPieChart: PieChartView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        transactionsChart(chartChoice: incomesPieChart, transactions: "income")
        transactionsChart(chartChoice: expensesPieChart, transactions: "expense")
        
        // print(getCategories() as Any)
        
    }
    
    func transactionsChart(chartChoice: PieChartView, transactions: String) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        let categoriesCount = getCategories()
        
        if let count = categoriesCount?.count{
            
            for i in 0..<count {
                
                let dataEntry = PieChartDataEntry(value:categoriesCount?[i].categories.sum(ofProperty: transactions) ?? 0.0, label: categoriesCount?[i].categoryName)
                
                dataEntries.append(dataEntry)
                
            }
            
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        
        var colors: [UIColor] = []
        
        if let count = categoriesCount?.count{
            
            // ustawiamy losowe kolory dla kazdej kategorii
            for _ in 0..<count {
                
                let color = UIColor.randomFlat
                colors.append(color)
                
            }
            
        }
        
        chartDataSet.colors = colors
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        chartChoice.data = chartData
        
    }
    
    func getCategories() -> Results<Categories>? {
        
        let realm = try! Realm()
        
        return realm.objects(Categories.self)
        
    }
    
}
