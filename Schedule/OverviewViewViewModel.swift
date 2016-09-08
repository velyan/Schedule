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

    private var models: [NSManagedObject]?
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
    
    func viewModelToPresent(atIndex: Int?) -> BaseViewModel {
        guard let index = atIndex where index < models?.count else {
            return ScheduleCreatorViewViewModel(model: nil)
        }
        let model = models![atIndex!]
        return ScheduleCreatorViewViewModel(model: model)
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