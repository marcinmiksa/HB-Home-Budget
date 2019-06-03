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
        
        transactionsChart(selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
        transactionsChart(selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
        
        // print(getCategories() as Any)
        
    }
    
    func transactionsChart(selectChart: PieChartView, transactions: String, chartLabel: String) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        let categories = getCategories()
        
        var colors: [UIColor] = []
        
        if let categoriesCount = categories?.count{
            
            for i in 0..<categoriesCount {
                
                let dataEntry = PieChartDataEntry(value:categories?[i].categories.sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                let color = UIColor(hexString: (categories?[i].categoryColor) ?? "#000000")
                
                if dataEntry.value != 0 {
                    
                    dataEntries.append(dataEntry)
                    colors.append(color!)
                    
                }
                
            }
            
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: chartLabel)
        
        chartDataSet.colors = colors
        
        let legend = selectChart.legend
        legend.direction = .rightToLeft
        legend.font = UIFont(name: "AvenirNext-Regular", size: 14)!
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        selectChart.data = chartData
        
    }
    
    func getCategories() -> Results<Categories>? {
        
        let realm = try! Realm()
        
        return realm.objects(Categories.self)
        
    }
    
    // MARK: date range calendar 
    
}
