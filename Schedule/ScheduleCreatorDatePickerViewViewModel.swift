//
//  ScheduleDatePickerViewViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreGraphics

class ScheduleCreatorDatePickerViewViewModel : BaseViewModel {
    
    fileprivate(set) var minDate: Dynamic<Date> = Dynamic(Date())
    override var height: Dynamic<CGFloat> {
        get {
            return Dynamic(216)
        }
        set{}
    }
}
