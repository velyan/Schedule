//
//  SchduleCreatorViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation

class ScheduleCreatorViewViewModel : BaseViewModel, BaseViewModelHierarchy {
    
    static private var defaultModel : ScheduleModel {
        get {
            let model = ScheduleModel()
            model.beginDate = NSDate()
            return model
        }
    }
    
    var model: Dynamic<AnyObject?>
    var children: Array<BaseViewModel> = Array<BaseViewModel>()
    
    init(model: AnyObject?) {
        let newModel = (model == nil) ? ScheduleCreatorViewViewModel.defaultModel : model
        self.model = Dynamic(newModel)
        createChildren()
        configureBindings()
    }
    
    func reset() {
        self.model.value = ScheduleCreatorViewViewModel.defaultModel
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
