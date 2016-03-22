//
//  Datapoint.swift
//  Circulations
//
//  Created by Matthew Gabor on 3/21/16.
//  Copyright © 2016 mattgabor. All rights reserved.
//

import Foundation
import CoreData

class Peak: NSManagedObject {
    @NSManaged var name:String?
    @NSManaged var detail:String?
    @NSManaged var price:NSNumber?
    
}