//
//  GraphViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 07/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lineChart: LineChartView!
    
    // MARK: - Variables
    var date: [String]?
    var valuesAuto: [Double]?
    var valuesManual: [Double]?
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        
        // Preparing the custom back button
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "BackBtn"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn.addTarget(self, action: #selector(GraphViewController.backButtonPressed), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        let item = UIBarButtonItem(customView: btn)
        
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
        // Custom title
        let infoTitle = UILabel()
        infoTitle.text = "Breathing History"
        let fontname = "Roboto-Bold"
        infoTitle.font = UIFont(name: "\(fontname)", size: 17)
        infoTitle.textColor = UIColor.init(red: 248/255, green: 162/255, blue: 118/255, alpha: 1)
        
        
        let stackView = UIStackView(arrangedSubviews: [infoTitle])
        stackView.axis = .horizontal
        stackView.frame.size.width = infoTitle.frame.width
        stackView.frame.size.height = infoTitle.frame.height
        
        self.navigationItem.titleView = infoTitle
        
        // Fill up chart data
        date = ["Jun 23", "Jun 24", "Jun 25", "Jun 26"]
        valuesAuto = [5.0, 2.0, 3.0, 6.0]
        valuesManual = [0.0, 1.0, 2.0, 1.0]
        setChartValue(date: date!, valuesAuto: valuesAuto!, valuesManual: valuesManual!)
        
        super.viewDidLoad()
        
    }
    
    // MARK: - Button Delegate
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
 
    func setChartValue(date:[String], valuesAuto:[Double], valuesManual:[Double]){
        var chartDataEntries1: [ChartDataEntry] = []
        var chartDataEntries2: [ChartDataEntry] = []
        
        for i in 0...3 {
            let dataEntry1 = ChartDataEntry(x: Double(i), y: valuesAuto[i], data: date[i] as AnyObject)
            let dataEntry2 = ChartDataEntry(x: Double(i), y: valuesManual[i], data: date[i] as AnyObject)
            chartDataEntries1.append(dataEntry1)
            chartDataEntries2.append(dataEntry2)
        }
        
        let chartDataSet1 = LineChartDataSet(values: chartDataEntries1, label: "Reminded Breathing                  ")
        chartDataSet1.circleRadius = 5
        chartDataSet1.circleHoleRadius = 2
        chartDataSet1.drawValuesEnabled = false
        chartDataSet1.colors = [NSUIColor.init(red: 248/255, green: 162/255, blue: 118/255, alpha: 1.0)]
        chartDataSet1.circleColors = [NSUIColor.init(red: 248/255, green: 162/255, blue: 118/255, alpha: 1.0)]
        chartDataSet1.circleHoleColor = NSUIColor.init(red: 248/255, green: 162/255, blue: 118/255, alpha: 1.0)
        
        let chartDataSet2 = LineChartDataSet(values: chartDataEntries2, label: "Personal Breathing")
        chartDataSet2.circleRadius = 5
        chartDataSet2.circleHoleRadius = 2
        chartDataSet2.drawValuesEnabled = false
        chartDataSet2.colors = [NSUIColor.init(red: 126/255, green: 202/255, blue: 224/255, alpha: 1.0)]
        chartDataSet2.circleColors = [NSUIColor.init(red: 126/255, green: 202/255, blue: 224/255, alpha: 1.0)]
        chartDataSet2.circleHoleColor = NSUIColor.init(red: 126/255, green: 202/255, blue: 224/255, alpha: 1.0)
        
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
        lineChart.data = chartData
        
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: date)
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.avoidFirstLastClippingEnabled = true
        
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false
        
        lineChart.pinchZoomEnabled = false
//        lineChart.doubleTapToZoomEnabled = false
        
        lineChart.chartDescription?.text = ""
    }
}
