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
    
    var allData = [String:[Any]]()
   
    func parseData(filename: String) {
        do {
            
            let urlpath = NSBundle.mainBundle().pathForResource("mission_peak_data_min", ofType: "csv")
            let url:NSURL = NSURL.fileURLWithPath(urlpath!)
            
            let csv = try CSV(url: url)
            
            allData["date"] = [String]()
            allData["time"] = [String]()
            allData["stanford"] = [CGFloat]()
            allData["ohlone"] = [Int]()
            allData["total"] = [Int]()

            for row in csv.rows {
                allData["date"]?.append(row["Date"])
                allData["time"]?.append(row["Time"])
                allData["stanford"]?.append(row["Stanford Entrance"])
                allData["ohlone"]?.append(row["Ohlone College Entrance"])
                allData["total"]?.append(row["Total"])
                
            }
        
            
        } catch {
            // Error handling
            print("Could not parse \(filename)")
        }
    }
}

