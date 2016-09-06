//
//  SchduleCreatorViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation

class SchduleCreatorViewViewModel : BaseViewModel {
    
    private(set) var beginDate : Dynamic<String?> = Dynamic(nil)
    private(set) var endDate: Dynamic<String?> = Dynamic(nil)
    private(set) var minBeginDate: Dynamic<NSDate> = Dynamic(NSDate())
    private(set) var date: Dynamic<NSDate?> = Dynamic(nil)
    private(set) var beginDateLabel: Dynamic<String> =  Dynamic(String.localizedStringWithFormat("Begin:", 0))
    private(set) var endDateLabel: Dynamic<String>  = Dynamic(String.localizedStringWithFormat("End Date:", 0))
    private let dateTransformer: DateTransformer = DateTransformer()
    
    var model: AnyObject? {
        didSet {
            didSetModel(model)
        }
    }
    
    static func new(model: AnyObject?) -> BaseViewModel {
        return SchduleCreatorViewViewModel.self(model: model)
    }
    
    init(model: AnyObject?) {
        self.model = model
        beginDate = Dynamic(nil)
        didSetModel(self.model)
        date.bindAndFire { [unowned self] in
            self.didSetDate($0)
        }
    }

    private func didSetModel(model: AnyObject?) {
        if let schedule = model as? ScheduleModel {
            date.value = schedule.beginDate
        }
    }
    
    private func didSetDate(date: NSDate?) {
        let endDate = date?.dateByAddingTimeInterval(60*60*24*7)
        updateLabels(date, endDate: endDate)
        updateModel(date, endDate: endDate)
    }
    
    private func updateLabels(beginDate: NSDate?, endDate: NSDate?) {
        if let begin = dateTransformer.transformedValue(beginDate) as? String {
            self.beginDate.value = begin
        }
        if let end = dateTransformer.transformedValue(endDate) as? String {
            self.endDate.value = end
        }
    }
    
    private func updateModel(beginDate: NSDate?, endDate: NSDate?) {
        if let schdule = model as? ScheduleModel {
            schdule.beginDate = beginDate
            schdule.endDate = endDate
        }
    }
}
