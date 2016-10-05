//
//  ScheduleDateViewViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreGraphics

class ScheduleCreatorDateViewViewModel : BaseViewModel {
    
    fileprivate(set) var date: Dynamic<String?> = Dynamic(nil)
    fileprivate(set) var label: Dynamic<String?> = Dynamic(nil)
    override var height: Dynamic<CGFloat> {
        get {
            return Dynamic(100)
        }
        set{}
    }
    
    override init(model: AnyObject?) {
        super.init(model: model)
        self.model.bindAndFire{ [unowned self] in
            let dateString = self.dateTransformer.transformedValue($0 as? Date) as? String
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
