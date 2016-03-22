//
//  ViewController.swift
//  Circulations
//
//  Created by Matthew Gabor on 3/21/16.
//  Copyright © 2016 mattgabor. All rights reserved.
//

import UIKit
import PNChartSwift


class OhloneViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        
        ChartLabel.textColor = UIColor.blueColor()
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.textAlignment = NSTextAlignment.Center
        
        //Add LineChart
        ChartLabel.text = "Ohlone Visitors"
        
        let lineChartWidth: CGFloat = screenSize.width * 0.9
        let lineChartHeight: CGFloat = screenSize.height *  0.6
        
        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake((screenSize.width * 0.5) - (lineChartWidth * 0.5), (screenSize.height * 0.5) - (lineChartHeight * 0.5), lineChartWidth, lineChartHeight))
        
        lineChart.yLabelFormat = "%1.1f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        lineChart.showCoordinateAxis = true
//        lineChart.delegate = self
        
        // Line Chart Nr.1
        var data01Array: [CGFloat] = [40.1, 110.1, 41.4, 22.2, 60.2, 12.2, 125.2]
        let data01:PNLineChartData = PNLineChartData()
        data01.color = Colors.niagra
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart.chartData = [data01]
        lineChart.strokeChart()
        
        //lineChart.delegate = self
        lineChart.tag = 101
        self.view.addSubview(lineChart)
        //self.view.addSubview(ChartLabel)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if let viewWithTag = self.view.viewWithTag(101) {
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

