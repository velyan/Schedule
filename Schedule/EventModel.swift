//
//  EventModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation

class EventModel : NSObject {
    
    var beginDate: NSDate?
    var endDate: NSDate?
    
    init(beginDate: NSDate) {
        self.beginDate = beginDate
    }
}