//
//  OverviewViewViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/8/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let kScheduleModelEntityName = "ScheduleModel"

class OverviewViewViewModel: BaseViewModel {

    private var models: Array<NSManagedObject>?
    override init(model: AnyObject?) {
        super.init(model: model)
        reload()
    }
    
    func reload() {
        if let fetchedModels = self.dataController.fetch(kScheduleModelEntityName, sortDescriptors: sortDescriptors()) {
            models = fetchedModels
            children = viewModels(fetchedModels)
        }
    }
    
    func scheduleCreatorViewModelAtIndex(index: Int?) -> BaseViewModel {
        guard let index = index where index < children.count else {
            return ScheduleCreatorViewViewModel(model: nil)
        }
        let model = models![index]
        return ScheduleCreatorViewViewModel(model: model)
    }
    
    func deleteViewModelAtIndex(index: Int) {
        guard index < children.count else {
            return
        }
        if let modelToDelete = children[index].model.value as? NSManagedObject {
            dataController.managedObjectContext?.deleteObject(modelToDelete)
            dataController.save()
            models?.removeAtIndex(index)
            children.removeAtIndex(index)
        }
    }
    
    private func sortDescriptors() -> Array<NSSortDescriptor> {
        let beginDateSort = NSSortDescriptor(key: "beginDate", ascending: true)
        let endDateSort = NSSortDescriptor(key: "endDate", ascending: true)
        return [beginDateSort, endDateSort]
    }
    
    private func viewModels(models: Array<AnyObject>) -> Array<BaseViewModel> {
        var viewModels = Array<BaseViewModel>()
        for model in models {
            let detailViewModel = OverviewDetailViewViewModel(model: model)
            viewModels.append(detailViewModel)
        }
        return viewModels
    }
}