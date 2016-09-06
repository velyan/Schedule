//
//  DateTransformer.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation

class DateTransformer: NSValueTransformer {
    
    private static let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        guard let date = value as? NSDate else { return nil }
        return DateTransformer.self.formatter.stringFromDate(date)
    }
}