//
//  Datasets.swift
//  Circulations
//
//  Created by Matthew Gabor on 3/21/16.
//  Copyright © 2016 mattgabor. All rights reserved.
//

import Foundation
import SwiftCSV
import PNChartSwift

class CSVParser {

    static let sharedInstance = CSVParser()
    
    var stringData = [String:[String]](),
    numericalData = [String:[CGFloat]]()
   
    func parseData(filename: String) {
        do {
            guard let urlpath = NSBundle.mainBundle().pathForResource(filename, ofType: "csv") else {
                print("Could not locate file \(filename)")
                exit(0)
            }
            let url = NSURL.fileURLWithPath(urlpath),
            csv = try CSV(url: url)


            stringData["date"] = [String]()
            stringData["time"] = [String]()
            numericalData["stanford"] = [CGFloat]()
            numericalData["ohlone"] = [CGFloat]()
            numericalData["total"] = [CGFloat]()
            
            var x = 0

            for row in csv.rows {
                if let date = row["Date"], time = row["Time"], stanford = row["Stanford Entrance"], ohlone = row["Ohlone College Entrance"], total = row["Total"] {
                    
                    numericalData["stanford"]?.append(CGFloat((NSString(string: stanford).floatValue)))
                    numericalData["ohlone"]?.append(CGFloat((NSString(string: ohlone).floatValue)))
                    numericalData["total"]?.append(CGFloat((NSString(string: total).floatValue)))
                    
                    if x < 25 {
                        stringData["date"]?.append(date)
                        stringData["time"]?.append(time)
                    }
                    x += 1
                }
            }
        } catch {
            // Error handling
            print("Could not parse \(filename)")
        }
    }
    
    func splitDays(allDays: [CGFloat]) -> [[CGFloat]] {
        // Parse data into days
        
        var parsedVisitors = [[CGFloat]]()
        var dailyVisitors = [CGFloat]()
        
        
        var i = 0
        
        for visitor in allDays {
            
            dailyVisitors.append(visitor)
            
            i += 1
            
            if i % 24 == 0 {
                parsedVisitors.append(dailyVisitors)
                dailyVisitors.removeAll(keepCapacity: false)
            }
        }
        
        return parsedVisitors
    }
    
    // Compute average of 1st index of array, 2nd index of array, etc
    func computeAverages(parsedVisitors: [[CGFloat]]) -> [CGFloat] {
        
        var dailyAverages = [CGFloat]()
        var totalDailyVisitors = [CGFloat](count: 24, repeatedValue: 0.0)

        for day in 0...parsedVisitors.count - 1 {
            for hour in 0...parsedVisitors[day].count - 1 {
                totalDailyVisitors[hour] += parsedVisitors[day][hour]
            }
        }
        
        for group in totalDailyVisitors {
            dailyAverages.append(group / CGFloat(totalDailyVisitors.count))
        }
        
        return dailyAverages
    }
    
    func addDataLine(yVals: [CGFloat]) -> PNLineChartData {
        
        var data01Array: [CGFloat] = yVals
        let data01:PNLineChartData = PNLineChartData()
        data01.color = Colors.lightRed
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        return data01
    }
}
