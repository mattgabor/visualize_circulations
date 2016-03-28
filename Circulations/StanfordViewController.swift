//
//  ViewController.swift
//  Circulations
//
//  Created by Matthew Gabor on 3/21/16.
//  Copyright © 2016 mattgabor. All rights reserved.
//

import UIKit
import PNChartSwift

class StanfordViewController: UIViewController {
    
    var lsHeight: CGFloat!,
    lsWidth: CGFloat!,
    numberOfScreens: CGFloat!,
    lineChartWidth: CGFloat!,
    lineChartHeight: CGFloat!,
    xVal: CGFloat!,
    yVal: CGFloat!,
    times: [String]!
    
    @IBOutlet weak var chartLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var scrollView: UIScrollView!
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        
        times = [String]()
        
        for i in 0...23 {
            times.append("\(i)")
        }
        
        // Data Conversion
        
        CSVParser.sharedInstance.parseData("mission_peak_data_jan")

        // Hardcode 6+ for now
        // Initial size setup
        lsHeight = 414
        lsWidth = 736
        numberOfScreens = 1
        
        lineChartWidth = lsWidth * numberOfScreens
        lineChartHeight = lsHeight * 0.62
        
        xVal = 0
        yVal = 0
        
        
        
        // Set up scroll view
        let svRect =  CGRectMake(0, 100, view.bounds.width, lineChartHeight)
        scrollView = UIScrollView(frame: svRect)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: lineChartWidth, height: lineChartHeight)
        // Set up line chart
        let lineChart = drawLineChart(CSVParser.sharedInstance.numericalData["stanford"]!)
        scrollView.addSubview(lineChart)
        scrollView.tag = 101
        self.view.addSubview(scrollView)
    }
    
    func drawLineChart(yVals: [CGFloat]) -> PNLineChart {
        lsHeight = 414
        lsWidth = 736
        numberOfScreens = 1
        
        lineChartWidth = lsWidth * numberOfScreens
        lineChartHeight = lsHeight * 0.62
        
        xVal = 0
        yVal = 0
        
        // Set up line chart
        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake(xVal, yVal, lineChartWidth, lineChartHeight))
        
        lineChart.yLabelFormat = "%.0f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.xLabels = times
        lineChart.showCoordinateAxis = true
        
        let parsedVisitors = CSVParser.sharedInstance.splitDays(yVals)
        var lines = [PNLineChartData]()
        
        
        for day in parsedVisitors {
            lines.append(CSVParser.sharedInstance.addDataLine(day))
        }
        
        lineChart.chartData = lines
        lineChart.strokeChart()
        lineChart.tag = 100
        
        return lineChart
    }
    
    func drawBarChart(yVals: [CGFloat]) -> PNBarChart {
        
        let barChart = PNBarChart(frame: CGRectMake(xVal, yVal + 25, lineChartWidth, lineChartHeight - 30))
        barChart.backgroundColor = UIColor.clearColor()

        // remove for default animation (all bars animate at once)
        barChart.animationType = .Waterfall
        
        barChart.labelMarginTop = 5.0
        barChart.xLabels = times
        barChart.yValues = CSVParser.sharedInstance.computeAverages(CSVParser.sharedInstance.splitDays(yVals))
        barChart.strokeChart()
        barChart.tag = 103
        
        return barChart
    }

    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            if let barChart = self.view.viewWithTag(103) {
                chartLabel.hidden = true
                scrollView.addSubview(drawLineChart(CSVParser.sharedInstance.numericalData["stanford"]!))
                barChart.removeFromSuperview()
            }
            
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            if let lineChart = self.view.viewWithTag(100), scrollView = self.view.viewWithTag(101) {
                lineChart.removeFromSuperview()
                
                scrollView.addSubview(drawBarChart(CSVParser.sharedInstance.numericalData["stanford"]!))
                
                chartLabel.hidden = false
            }
        }
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        if let lineChart = self.view.viewWithTag(100), barChart = self.view.viewWithTag(103) {
            lineChart.removeFromSuperview()
            barChart.removeFromSuperview()
        }
        else {
            print("tag not found", terminator: "")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//guard let dateVals = CSVParser.sharedInstance.stringData["date"], timeVals = CSVParser.sharedInstance.stringData["time"], stanfordVals = CSVParser.sharedInstance.numericalData["stanford"], else {
//    print("Data not assigned properly")
//    return
//}
