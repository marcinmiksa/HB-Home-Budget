import UIKit
import RealmSwift
import Charts
import ChartsRealm
import ChameleonFramework
import SWFrameButton

class ChartViewController: UIViewController {
    
    @IBOutlet weak var incomesPieChart: PieChartView!
    @IBOutlet weak var expensesPieChart: PieChartView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        transactionsChart(selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
        transactionsChart(selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
        
        SWFrameButton.appearance().tintColor = .flatBlack
        
        // MARK : nie dziala ustawienie kontrastu koloru tekstu na wykresie
        // ustawienie czarnej czcionki na bialym tle wykresu kolowego
        // incomesPieChart.data?.setValueTextColor(ContrastColorOf(color!, returnFlat: true))
        // expensesPieChart.data?.setValueTextColor(ContrastColorOf(color!, returnFlat: true))
        
    }
    
    func transactionsChart(selectChart: PieChartView, transactions: String, chartLabel: String) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        let categories = getCategories()
        
        var colors: [UIColor] = []
        
        if let categoriesCount = categories?.count{
            
            for i in 0..<categoriesCount {
                
                let dataEntry = PieChartDataEntry(value:categories?[i].categories.sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                let color = UIColor(hexString: ((categories?[i].categoryColor)!))
                
                if dataEntry.value != 0 {
                    
                    dataEntries.append(dataEntry)
                    colors.append(color!)
                    
                }
                
            }
            
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: chartLabel)
        
        // jesli nie ma danych nie wyswietla sie etykieta wykresu
        if chartDataSet.entries.count != 0 {
            
            chartDataSet.label = chartLabel
            
        } else {
            
            chartDataSet.label = ""
            
        }
        
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
    
    // MARK: zrob filtrowanie danych na wykresie
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            print("1")
            
        } else if sender.tag == 2 {
            
            print("2")
            
        } else {
            
            print("3")
            
        }
        
    }
    
}
