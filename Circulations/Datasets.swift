//
//  Datasets.swift
//  Circulations
//
//  Created by Matthew Gabor on 3/21/16.
//  Copyright © 2016 mattgabor. All rights reserved.
//

import Foundation
import SwiftCSV

class CSVParser {

    static let sharedInstance = CSVParser()
    
//    var allData = [String:[Any]]()
    
    var stringData = [String:[String]](),
    numericalData = [String:[CGFloat]]()
   
    func parseData(filename: String) {
        do {
            let urlpath = NSBundle.mainBundle().pathForResource(filename, ofType: "csv"),
            url:NSURL = NSURL.fileURLWithPath(urlpath!),
            csv = try CSV(url: url)


            stringData["date"] = [String]()
            stringData["time"] = [String]()
            numericalData["stanford"] = [CGFloat]()
            numericalData["ohlone"] = [CGFloat]()
            numericalData["total"] = [CGFloat]()
            
            var x = 0

            for row in csv.rows {
                if let date = row["Date"], time = row["Time"], stanford = row["Stanford Entrance"], ohlone = row["Ohlone College Entrance"], total = row["Total"] {
                    if x < 500 {
                        stringData["date"]?.append(date)
                        stringData["time"]?.append(time)
                        numericalData["stanford"]?.append(CGFloat((NSString(string: stanford).floatValue)))
                        numericalData["ohlone"]?.append(CGFloat((NSString(string: ohlone).floatValue)))
                        numericalData["total"]?.append(CGFloat((NSString(string: total).floatValue)))
                    }
                    x += 1
                }
            }
        } catch {
            // Error handling
            print("Could not parse \(filename)")
        }
    }
}


// Alternative implementation


//            allData["date"] = [String]()
//            allData["time"] = [String]()
//            allData["stanford"] = [CGFloat]()
//            allData["ohlone"] = [Int]()
//            allData["total"] = [Int]()
//
//            for row in csv.rows {
//                allData["date"]?.append(row["Date"])
//                allData["time"]?.append(row["Time"])
//                allData["stanford"]?.append(row["Stanford Entrance"])
//                allData["ohlone"]?.append(row["Ohlone College Entrance"])
//                allData["total"]?.append(row["Total"])
//            }

