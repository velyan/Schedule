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
    
    private(set) var beginLabel: Dynamic<String>? = Dynamic(String.localizedStringWithFormat("Begin:", 0))
    private(set) var endLabel: Dynamic<String>? = Dynamic(String.localizedStringWithFormat("End:", 0))
    private(set) var beginDateLabel: Dynamic<String>?
    private(set) var endDateLabel: Dynamic<String>?
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
    
    private func updateLabels(model: AnyObject?) {
        if let schedule = model as? ScheduleModel {
            if let beginDate = dateToString(schedule.beginDate) {
                beginDateLabel = Dynamic(beginDate)
            }
            if let endDate = dateToString(schedule.endDate) {
                endDateLabel = Dynamic(endDate)
            }
        }
    }
    
    private func dateToString(date: NSDate?)-> String? {
        return dateTransformer.transformedValue(date) as? String
    }
}