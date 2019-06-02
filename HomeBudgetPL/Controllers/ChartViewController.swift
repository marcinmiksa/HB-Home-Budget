import UIKit
import RealmSwift
import Charts
import ChartsRealm

class ChartViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateTransactionsChart()
        
        // print(getCategories() as Any)
        
    }
    
    func updateTransactionsChart() {
        
        var dataEntries: [PieChartDataEntry] = []
        
        let categoriesCount = getCategories()
        
        if let count = categoriesCount?.count{
            
            for i in 0..<count {
                
                let dataEntry = PieChartDataEntry(value:categoriesCount?[i].categories.sum(ofProperty: "income") ?? 0.0, label: categoriesCount?[i].categoryName)
                
                dataEntries.append(dataEntry)
                
                // print(categoriesCount?[i].categoryName as Any)
                
            }
            
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        
        var colors: [UIColor] = []
        
        if let count = categoriesCount?.count{
            
            // ustawiamy losowe kolory dla kazdej kategorii
            for _ in 0..<count {
                
                let red = Double(arc4random_uniform(256))
                let green = Double(arc4random_uniform(256))
                let blue = Double(arc4random_uniform(256))
                
                let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
                colors.append(color)
                
            }
            
        }
        
        chartDataSet.colors = colors
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        pieChart.data = chartData
        
    }
    
    func getCategories() -> Results<Categories>? {
        
        let realm = try! Realm()
        
        return realm.objects(Categories.self)
        
    }
    
}
