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
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var scrollView: UIScrollView!
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        
        // Data Conversion
        
        CSVParser.sharedInstance.parseData("mission_peak_data_min")
    
        // Do any additional setup after loading the view, typically from a nib.

        let ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        
        ChartLabel.textColor = PNGreenColor
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.textAlignment = NSTextAlignment.Center
        
        //Add LineChart
        ChartLabel.text = "Stanford Visitors"
        
        // Portrait
//        let lineChartWidth: CGFloat = screenSize.width * 0.9
//        let lineChartHeight: CGFloat = screenSize.height *  0.6
//        
//        
//        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake((screenSize.width * 0.5) - (lineChartWidth * 0.5), (screenSize.height * 0.5) - (lineChartHeight * 0.5), lineChartWidth, lineChartHeight))
        
        // Landscape
//        let lsHeight = screenSize.width,
//        lsWidth = screenSize.height
        
//        let lineChartWidth: CGFloat = lsWidth
//        let lineChartHeight: CGFloat = lsHeight * 0.75
//        let xVal: CGFloat = (lsWidth * 0.5) - (lineChartWidth * 0.5)
//        let yVal: CGFloat = (lsHeight * 0.5) - (lineChartHeight * 0.5)
        
        // Hardcode 6+
//        let lsHeight = 
        let lsHeight: CGFloat = 414,
        lsWidth: CGFloat = 736,
        numberOfScreens: CGFloat = 2,
        
        lineChartWidth: CGFloat = lsWidth * numberOfScreens,
        lineChartHeight: CGFloat = lsHeight * 0.62,
        
        xVal: CGFloat = 0,
        yVal: CGFloat = 0,
        
        lineChart:PNLineChart = PNLineChart(frame: CGRectMake(xVal, yVal, lineChartWidth, lineChartHeight))
        
        lineChart.yLabelFormat = "%1f"
        lineChart.showLabel = false
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.xLabels = CSVParser.sharedInstance.stringData["time"]!
        lineChart.showCoordinateAxis = false
//        lineChart.delegate = self
        
        // Line Chart Nr.1

        var data01Array: [CGFloat] = CSVParser.sharedInstance.numericalData["stanford"]!
        let data01:PNLineChartData = PNLineChartData()
        data01.color = Colors.lightRed
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart.chartData = [data01]
        lineChart.strokeChart()
        
        //        lineChart.delegate = self
        lineChart.tag = 100
//        self.view.addSubview(lineChart)
        
        // Set up scroll view
        let svRect =  CGRectMake(0, 100, view.bounds.width, lineChartHeight)
        scrollView = UIScrollView(frame: svRect)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = lineChart.bounds.size
//        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        scrollView.addSubview(lineChart)
        self.view.addSubview(scrollView)
        //scrollView.backgroundColor = UIColor.redColor()
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        if segmentedControl.selectedSegmentIndex == 1 {
//            print("segment 1")
//            scrollView.removeFromSuperview()
//        } else {
//            print(segmentedControl.selectedSegmentIndex)
//        }
//    }
    
    override func viewWillDisappear(animated: Bool) {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
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
