//            stringData["date"] = [String]()
//            stringData["time"] = [String]()
//            numericalData["stanford"] = [CGFloat]()
//            numericalData["ohlone"] = [CGFloat]()
//            numericalData["total"] = [CGFloat]()
//            
//            for row in csv.rows {
//                if let date = row["Date"], time = row["Time"], stanford = row["Stanford Entrance"], ohlone = row["Ohlone College Entrance"], total = row["Total"] {
//                    stringData["date"]?.append(date)
//                    stringData["time"]?.append(time)
//                    numericalData["stanford"]?.append(CGFloat((NSString(string: stanford).floatValue)))
//                    numericalData["ohlone"]?.append(ohlone)
//                    numericalData["total"]?.append(total)
//            }