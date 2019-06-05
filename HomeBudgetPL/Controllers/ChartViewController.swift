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
        
    }
    
    func transactionsChart(select: String, selectChart: PieChartView, transactions: String, chartLabel: String) {
        
        let currentDate = Date()
        
        var dataEntries: [PieChartDataEntry] = []
        
        let categories = getCategories()
        
        var chartColors: [UIColor] = []
        
        if let categoriesCount = categories?.count{
            
            for i in 0..<categoriesCount {
                
                if select == "all" {
                    
                    let dataEntry = PieChartDataEntry(value:categories?[i].categories.sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                    
                    let chartColor = UIColor(hexString: ((categories?[i].categoryColor)!))
                    
                    if dataEntry.value != 0 {
                        
                        dataEntries.append(dataEntry)
                        chartColors.append(chartColor!)
                        
                    }
                    
                } else if select == "lastThirty" {
                    
                    let changedDate = changeDateBy(days: -30)
                    
                    let dataEntry = PieChartDataEntry(value:categories?[i].categories.filter("dataTransaction BETWEEN {%@, %@}", changedDate, currentDate).sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                    
                    let colorChart = UIColor(hexString: ((categories?[i].categoryColor)!))
                    
                    if dataEntry.value != 0 {
                        
                        dataEntries.append(dataEntry)
                        chartColors.append(colorChart!)
                        
                    }
                    
                } else if select == "currentMonth" {
                    
                    let firstDayOfMonth = firstDayOfCurrentMonth()
                    let lastDayOfMonth = lastDayOfCurrentMonth()
                    
                    let dataEntry = PieChartDataEntry(value:categories?[i].categories.filter("dataTransaction BETWEEN {%@, %@}", firstDayOfMonth, lastDayOfMonth).sum(ofProperty: transactions) ?? 0.0, label: categories?[i].categoryName)
                    
                    let colorChart = UIColor(hexString: ((categories?[i].categoryColor)!))
                    
                    if dataEntry.value != 0 {
                        
                        dataEntries.append(dataEntry)
                        chartColors.append(colorChart!)
                        
                    }
                    
                }
                
            }
            
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: chartLabel)
        
        // brak transakcji w bazie = nie wyswietla sie etykieta chartLabel
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
    
    func getCategories() -> Results<Categories>? {
        
        let realm = try! Realm()
        
        return realm.objects(Categories.self)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            transactionsChart(select: "lastThirty", selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
            transactionsChart(select: "lastThirty", selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
            
        } else if sender.tag == 2 {
            
            transactionsChart(select: "currentMonth", selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
            transactionsChart(select: "currentMonth", selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
            
        } else {
            
            transactionsChart(select: "all", selectChart: incomesPieChart, transactions: "income", chartLabel: "Przychody: ")
            transactionsChart(select: "all", selectChart: expensesPieChart, transactions: "expense", chartLabel: "Wydatki: ")
            
        }
        
    }
    
}

extension UIViewController {
    
    // funkcja zwrace date kilka dni w przod lub wstecz
    func changeDateBy(days : Int) -> Date {
        
        var dateComponents = DateComponents()
        
        dateComponents.day = days
        
        return Calendar.current.date(byAdding: dateComponents, to: Date())!
        
    }
    
    // funkcja zwraca pierwszy dzien miesiaca
    func firstDayOfCurrentMonth() -> Date {
        
        var calendar = Calendar.current
        // musimy ustawic strefe czasowa w celu poprawnego wyswietlania daty
        calendar.timeZone = NSTimeZone(name: "GMT")! as TimeZone
        
        return calendar.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
    }
    
    // funkcja zwraca ostatni dzien miesiaca
    func lastDayOfCurrentMonth() -> Date {
        
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfCurrentMonth())!
        
    }
    
}
