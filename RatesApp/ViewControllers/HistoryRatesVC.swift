//
//  HistoryRatesVC.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import UIKit
import SwiftCharts
import Charts
import TinyConstraints


class HistoryRatesVC: UIViewController{
    
    private var vm = HistoryRatesVM(baseCurrency: SharedSettings.shared.baseCurrency)
    
    //MARK: - Views
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    /// Create a scrollview component
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.frame = self.view.bounds
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        view.contentSize = contentViewSize
        return view
    }()
    //// Create a container component
    lazy var container: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    /// Create a stackview component
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - HistoryRatesVC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        
        
    }
    
    ///clear the  charts from the stack view
    /// add the ui components
    /// fetch the history data
    override func viewDidAppear(_ animated: Bool) {
        clearView()
        container.addSubview((stackView))
        vm.getHistoryRatesData()
        
    }
    /// clear the stack view
    func clearView(){
        for item in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }
    
    
    //MARK: - Update Chart
    /// For each currency rate available in the view model, create a custom Line chart and populate it
    private func updateCharts() {
        for currency in  SharedSettings.shared.baseCurrency.getRemainingCurrenciesArray() {
            let currencyString = currency.rawValue
            let points = self.vm.getHistoryRates(for: currencyString)
            print("Chart points", points)
            let chart = getChartForCurrency(currency: self.vm.baseCurrency.rawValue)
            chart.data = getChartData(points, label: currencyString)
//            chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: points.1)
            chart.data?.setDrawValues(false)
            chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: points.0)
            stackView.addArrangedSubview(chart)
            
            chart.width(to: view)
            chart.heightToWidth(of: view)
        }
        
    }
    /// Create a custom chart for a given currency
       /// - Parameter currency: corresponding currency name
       private func getChartForCurrency(currency: String) -> LineChartView {
           let chartView = LineChartView()
           chartView.backgroundColor = .white
           chartView.rightAxis.enabled = false
           let yAxis = chartView.leftAxis
           yAxis.labelFont = .boldSystemFont(ofSize: 12)
           yAxis.setLabelCount(6, force: false)
           yAxis.labelTextColor = .systemTeal
           yAxis.axisLineColor = .systemTeal
           yAxis.labelPosition = .outsideChart
           let xAxis = chartView.xAxis
           xAxis.labelFont = .boldSystemFont(ofSize: 12)
           xAxis.setLabelCount(6, force: false)
           xAxis.labelTextColor = .systemTeal
           xAxis.axisLineColor = .systemTeal
           xAxis.labelPosition = .bottom
           xAxis.granularity = 2.0
           xAxis.granularityEnabled = true
           xAxis.setLabelCount(8, force: true)
           chartView.animate(xAxisDuration: 0.5)
           return chartView
       }
       
       /// Generate the chart data set for a given set of x and y coordinates values
       /// - Parameters:
       ///   - dataPoints: array of currency dates
       ///   - values: array of currency values
       ///   - label: currency type
     private func getChartData(_ dataPoints: ([String], [Double]), label: String) -> LineChartData {
           var entries: [ChartDataEntry] = Array()
           
        for (i, value) in dataPoints.1.enumerated() {
               entries.append(ChartDataEntry(x: Double(i), y: value))
           }
           
           let lineChartDataSet = LineChartDataSet(entries: entries, label: label)
           lineChartDataSet.mode = .cubicBezier
           lineChartDataSet.drawCirclesEnabled = false
           lineChartDataSet.setColor(.systemTeal)
           lineChartDataSet.fill = Fill(color: .systemTeal)
           lineChartDataSet.fillAlpha = 0.8
           lineChartDataSet.drawFilledEnabled = true
           lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
           lineChartDataSet.highlightColor = .systemRed
           var dataSets = [LineChartDataSet]()
           dataSets.append(lineChartDataSet)
           return LineChartData(dataSets: dataSets)
       }
    
}
//MARK: - View Model Delegate
extension HistoryRatesVC: HistoryRatesVMDelegate{
    func didFinishLoading() {
        print("Finished loading history data")
        self.updateCharts()
    }
    
    
}
class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?
    
    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}

extension ChartXAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
            let referenceTimeInterval = referenceTimeInterval
            else {
                return ""
        }
        
        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }
    
}
