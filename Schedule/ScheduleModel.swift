//
//  ScheduleModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreData

class ScheduleModel : NSManagedObject {
    @NSManaged var beginDate: NSDate?
    @NSManaged var endDate: NSDate?
}