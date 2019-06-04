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
        
        transactionsChart(select: "all", selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
        transactionsChart(select: "all", selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
        
        SWFrameButton.appearance().tintColor = .flatBlack
        
        setConstrastColor()
        
    }
    
    func transactionsChart(select: String, selectChart: PieChartView, transactions: String, chartLabel: String) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        let categories = getCategories()
        
        var chartColors: [UIColor] = []
        
        if let categoriesCount = categories?.count{
            
            for i in 0..<categoriesCount {
                
                if select == "all" {
                    
                    let dataEntry = PieChartDataEntry(value:categories?[i].categories.sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                    
                    setConstrastColor()
                    
                    let chartColor = UIColor(hexString: ((categories?[i].categoryColor)!))
                    
                    if dataEntry.value != 0 {
                        
                        dataEntries.append(dataEntry)
                        chartColors.append(chartColor!)
                        
                    }
                    
                } else if select == "lastThirty" {
                    
                    let today = Date()
                    let later = changeDaysBy(days: -30)
                    
                    let dataEntry = PieChartDataEntry(value:categories?[i].categories.filter("dataTransaction BETWEEN {%@, %@}", later, today).sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                    
                    setConstrastColor()
                    
                    let colorChart = UIColor(hexString: ((categories?[i].categoryColor)!))
                    
                    if dataEntry.value != 0 {
                        
                        dataEntries.append(dataEntry)
                        chartColors.append(colorChart!)
                        
                    }
                    
                } else {
                    
                    //MARK: zrob filtracje na biezacy miesiac
                    
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
        
        chartDataSet.colors = chartColors
        
        let legend = selectChart.legend
        legend.direction = .rightToLeft
        legend.font = UIFont(name: "AvenirNext-Regular", size: 14)!
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        selectChart.data = chartData
        
    }
    
    
    // MARK: nie dziala bo ustawilem tylko dla koloru bialego a powinno automatycznie z koloru wykresu
    // ustawienie kontrastu czcionki dla bialych kolorow
    func setConstrastColor() {
        
        incomesPieChart.data?.setValueTextColor(ContrastColorOf(UIColor.white, returnFlat: true))
        expensesPieChart.data?.setValueTextColor(ContrastColorOf(UIColor.white, returnFlat: true))
        
    }
    
    func getCategories() -> Results<Categories>? {
        
        let realm = try! Realm()
        
        return realm.objects(Categories.self)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            transactionsChart(select: "lastThirty", selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
            transactionsChart(select: "lastThirty", selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
            
        } else if sender.tag == 2 {
            
            //transactionsChart(selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
            //transactionsChart(selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
            
        } else {
            
            transactionsChart(select: "all", selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
            transactionsChart(select: "all", selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
            
        }
        
    }
    
}

extension UIViewController {
    
    func changeDaysBy(days : Int) -> Date {
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        
        dateComponents.day = days
        
        return Calendar.current.date(byAdding: dateComponents, to: currentDate)!
        
    }
    
}
