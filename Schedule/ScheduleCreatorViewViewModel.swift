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
    
    fileprivate var defaultModel : ScheduleModel {
        get {
            let context = self.dataController.managedObjectContext!
            let model = NSEntityDescription.insertNewObject(forEntityName: "ScheduleModel",
                                                                            into: context) as! ScheduleModel
            model.beginDate = Date()
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
    
    fileprivate func configureBindings() {
        let filtered = children.filter { $0 as? ScheduleCreatorDatePickerViewViewModel != nil}
        if let pickerVM = filtered.first {
            self.model.bind {
                if let beginDate = ($0 as? ScheduleModel)?.beginDate {
                    pickerVM.model.value = beginDate as AnyObject?
                }
            }
            
            pickerVM.model.bind { [unowned self] in
                self.didSetDate($0 as? Date)
            }
        }
        
    }

    fileprivate func createChildren() {
        children = Array<BaseViewModel>()
        if let schedule = model.value as? ScheduleModel {
            let beginDateVM = ScheduleCreatorBeginDateViewViewModel(model: schedule.beginDate as AnyObject?)
            let pickerVM = ScheduleCreatorDatePickerViewViewModel(model: schedule.beginDate as AnyObject?)
            let endDateVM = ScheduleCreatorEndDateViewViewModel(model: schedule.endDate as AnyObject?)
            let viewModels: Array<BaseViewModel> = [beginDateVM, pickerVM, endDateVM]
            children.append(contentsOf: viewModels)
        }
    }

    fileprivate func didSetDate(_ date: Date?) {
        let endDate = date?.addingTimeInterval(60*60*24*7)
        updateModel(date, endDate: endDate)
        updateViewModels(date, endDate: endDate)
    }

    fileprivate func updateModel(_ beginDate: Date?, endDate: Date?) {
        if let schedule = model.value as? ScheduleModel {
            schedule.beginDate = beginDate
            schedule.endDate = endDate
        }
    }
    
    fileprivate func updateViewModels(_ beginDate: Date?, endDate: Date?) {
        let beginVM = children.first
        let endVM = children.last
        beginVM?.model.value = beginDate as AnyObject?
        endVM?.model.value = endDate as AnyObject?
    }
    
}
