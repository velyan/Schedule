//
//  SchduleCreatorViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ScheduleCreatorViewViewModel : BaseViewModel {
    
    private var defaultModel : ScheduleModel {
        get {
            let context = self.dataController.managedObjectContext!
            let model = NSEntityDescription.insertNewObjectForEntityForName("ScheduleModel",
                                                                            inManagedObjectContext: context) as! ScheduleModel
            model.beginDate = NSDate()
            return model
        }
    }
    
    override init(model: AnyObject?) {
        super.init(model: model)
        let newModel = (model == nil) ? self.defaultModel : model
        self.model = Dynamic(newModel)
        createChildren()
        configureBindings()
    }
    
    func reset() {
        self.model.value = self.defaultModel
    }
    
    func save() {
        self.dataController.save()
    }
    
    private func configureBindings() {
        let filtered = children.filter { $0 as? ScheduleCreatorDatePickerViewViewModel != nil}
        if let pickerVM = filtered.first {
            self.model.bind {
                if let beginDate = ($0 as? ScheduleModel)?.beginDate {
                    pickerVM.model.value = beginDate
                }
            }
            
            pickerVM.model.bind { [unowned self] in
                self.didSetDate($0 as? NSDate)
            }
        }
        
    }

    private func createChildren() {
        children = Array<BaseViewModel>()
        if let schedule = model.value as? ScheduleModel {
            let beginDateVM = ScheduleCreatorBeginDateViewViewModel(model: schedule.beginDate)
            let pickerVM = ScheduleCreatorDatePickerViewViewModel(model: schedule.beginDate)
            let endDateVM = ScheduleCreatorEndDateViewViewModel(model: schedule.endDate)
            let viewModels: Array<BaseViewModel> = [beginDateVM, pickerVM, endDateVM]
            children.appendContentsOf(viewModels)
        }
    }

    private func didSetDate(date: NSDate?) {
        let endDate = date?.dateByAddingTimeInterval(60*60*24*7)
        updateModel(date, endDate: endDate)
        updateViewModels(date, endDate: endDate)
    }

    private func updateModel(beginDate: NSDate?, endDate: NSDate?) {
        if let schedule = model.value as? ScheduleModel {
            schedule.beginDate = beginDate
            schedule.endDate = endDate
        }
    }
    
    private func updateViewModels(beginDate: NSDate?, endDate: NSDate?) {
        let beginVM = children.first
        let endVM = children.last
        beginVM?.model.value = beginDate
        endVM?.model.value = endDate
    }
    
}
