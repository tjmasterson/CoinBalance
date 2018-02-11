//
//  PortfolioTableViewController.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/11/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import Charts

class PortfolioTableViewController: UITableViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let prices = [3585.0, 4676.30, 4947.90, 5678.0, 6239.90, 8978.0, 12786.0, 15756.56, 17034.0, 19883.40, 18569.10, 17893.43]
        let prices2 = [2585.0, 2676.30, 3947.90, 3678.0, 5239.90, 4978.0, 5786.0, 4756.56, 3034.0, 3883.40, 3569.10, 3893.43]
        setupLineChart(dataPoints: months)
        updateChartData(dataPoints: months, dataSetValues: [prices, prices2])
    }
    
    func setupLineChart(dataPoints: [String]) {
        // Chart Animations
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        
        // Chart Colors
        lineChartView.noDataTextColor = .white
        lineChartView.backgroundColor = .white
        
        // Chart Defaults
        lineChartView.noDataText = "No data found for chart"
        
        // Chart X-Axis
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)

        let xaxis: XAxis = XAxis()
        xaxis.valueFormatter = formatter
        lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false

        // Chart Y-Axis
        lineChartView.leftAxis.enabled = false
        // lineChartView.leftAxis.drawGridLinesEnabled = false
        // lineChartView.leftAxis.drawLabelsEnabled = true
    }
    
    func createChartDataSet(dataPoints: [String], values: [Double]) -> LineChartDataSet? {
        
        // Create list of ChartDataEntry objects
        var lineDataEntry: [ChartDataEntry] = []
        for index in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(index), y: values[index])
            lineDataEntry.append(dataPoint)
        }
        
        // Initialize LineChartDataSet
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: nil)
        
        // Chart Data Set Color
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.setCircleColor(UIColor.blue)
        chartDataSet.circleHoleColor = UIColor.white
        chartDataSet.circleRadius = 5.0
        
        // Gradient fill
        let gradientColors = [UIColor.blue.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            print("gradient color error")
            return nil
        }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        return chartDataSet
    }
    
    func updateChartData(dataPoints: [String], dataSetValues: [[Double]]) {
        
        // Create LineChartDataSet to be added to LineChartData
        var dataSets: [LineChartDataSet] = []
        for k in 0..<dataSetValues.count {
            if let dataSet = createChartDataSet(dataPoints: dataPoints, values: dataSetValues[k]) {
                dataSets.append(dataSet)
            }
        }
        
        // Initialize LineChartData and set options
        let chartData = LineChartData()
        chartData.setDrawValues(true)
        let data = LineChartData(dataSets: dataSets)
        
        // Add LineChartData to Chart
        lineChartView.data = data

    }
}

extension PortfolioTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

public class ChartFormatter: NSObject, IAxisValueFormatter {
    var values = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return values[Int(value)]
    }
    
    public func setValues(values: [String]) {
        self.values = values
    }
}
