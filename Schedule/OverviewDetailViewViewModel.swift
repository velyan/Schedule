//
//  OverviewDetailViewViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/8/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreGraphics

class OverviewDetailViewViewModel: BaseViewModel {
    
    fileprivate(set) var beginLabel: Dynamic<String>? = Dynamic(String.localizedStringWithFormat("Begin:", 0))
    fileprivate(set) var endLabel: Dynamic<String>? = Dynamic(String.localizedStringWithFormat("End:", 0))
    fileprivate(set) var beginDateLabel: Dynamic<String>?
    fileprivate(set) var endDateLabel: Dynamic<String>?
    override var height: Dynamic<CGFloat> {
        get {
            return Dynamic(100)
        }
        set{}
    }
    
    override init(model: AnyObject?) {
        super.init(model: model)
        updateLabels(model)
    }
    
    fileprivate func updateLabels(_ model: AnyObject?) {
        if let schedule = model as? ScheduleModel {
            if let beginDate = dateToString(schedule.beginDate as Date?) {
                beginDateLabel = Dynamic(beginDate)
            }
            if let endDate = dateToString(schedule.endDate as Date?) {
                endDateLabel = Dynamic(endDate)
            }
        }
    }
    
    fileprivate func dateToString(_ date: Date?)-> String? {
        return dateTransformer.transformedValue(date) as? String
    }
}
