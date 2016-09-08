//
//  ScheduleDateViewViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreGraphics

protocol DateViewModel {
    var date: Dynamic<String?> { get }
    var label: Dynamic<String?> { get }
}

class ScheduleCreatorDateViewViewModel : BaseViewModel, BaseViewModelPresentation, DateViewModel {
    
    private let dateTransformer: DateTransformer = DateTransformer()
    var model: Dynamic<AnyObject?>
    var date: Dynamic<String?> = Dynamic(nil)
    var label: Dynamic<String?> = Dynamic(nil)
    var height: Dynamic<CGFloat> = Dynamic(100)
    
    init(model: AnyObject?) {
        self.model = Dynamic(model)
        self.model.bindAndFire{ [unowned self] in
            let dateString = self.dateTransformer.transformedValue($0 as? NSDate) as? String
            self.date.value = dateString
        }
    }
}

class ScheduleCreatorBeginDateViewViewModel: ScheduleCreatorDateViewViewModel {
    override var label: Dynamic<String?> {
        get {
            return Dynamic(String.localizedStringWithFormat("Begin Date:", 0))
        }
        set {}
    }
}

class ScheduleCreatorEndDateViewViewModel: ScheduleCreatorDateViewViewModel {
    override var label: Dynamic<String?> {
        get {
            return Dynamic(String.localizedStringWithFormat("End Date:", 0))
        }
        set {}
    }
}