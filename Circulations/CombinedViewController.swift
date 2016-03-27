//
//  ViewController.swift
//  Circulations
//
//  Created by Matthew Gabor on 3/21/16.
//  Copyright © 2016 mattgabor. All rights reserved.
//

import UIKit
import PNChartSwift


class CombinedViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add BarChart
        
        let barChart = PNBarChart(frame: CGRectMake(0, 135.0, 320.0, 200.0))
        barChart.backgroundColor = UIColor.clearColor()
        //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
        //                var yValueParsed:CGFloat = yValue
        //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
        //                return labelText;
        //            })
        
        
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Waterfall
        
        
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        barChart.yValues = [1,24,12,18,30,10,21]
        barChart.strokeChart()
        
        self.view.addSubview(barChart)
        

//        let ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
//        
//        ChartLabel.textColor = UIColor.blueColor()
//        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
//        ChartLabel.textAlignment = NSTextAlignment.Center
//        
//        //Add LineChart
//        ChartLabel.text = "Ohlone Visitors"
//        
//        let lineChartWidth: CGFloat = screenSize.width * 0.9
//        let lineChartHeight: CGFloat = screenSize.height *  0.6
//        
//        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake((screenSize.width * 0.5) - (lineChartWidth * 0.5), (screenSize.height * 0.5) - (lineChartHeight * 0.5), lineChartWidth, lineChartHeight))
//        
//        lineChart.yLabelFormat = "%1.1f"
//        lineChart.showLabel = true
//        lineChart.backgroundColor = UIColor.clearColor()
//        lineChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
//        lineChart.showCoordinateAxis = true
////        lineChart.delegate = self
//        
//        // Line Chart Nr.1
//        var data01Array: [CGFloat] = [40.1, 110.1, 41.4, 22.2, 60.2, 12.2, 125.2]
//        let data01:PNLineChartData = PNLineChartData()
//        data01.color = Colors.niagra
//        data01.itemCount = data01Array.count
//        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
//        data01.getData = ({(index: Int) -> PNLineChartDataItem in
//            let yValue:CGFloat = data01Array[index]
//            let item = PNLineChartDataItem(y: yValue)
//            return item
//        })
//        
//        // Lien Chart Nr.2
//        var data02Array: [CGFloat] = [140.1, 10.1, 31.4, 52.2, 30.2, 82.2, 55.2]
//        let data02:PNLineChartData = PNLineChartData()
//        data02.color = Colors.lightRed
//        data02.itemCount = data01Array.count
//        data02.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
//        data02.getData = ({(index: Int) -> PNLineChartDataItem in
//            let yValue:CGFloat = data02Array[index]
//            let item = PNLineChartDataItem(y: yValue)
//            return item
//        })
//        
//        lineChart.chartData = [data01, data02]
//        lineChart.strokeChart()
//        
//        //lineChart.delegate = self
//        lineChart.tag = 102
//        self.view.addSubview(lineChart)
//        //self.view.addSubview(ChartLabel)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if let viewWithTag = self.view.viewWithTag(102) {
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

