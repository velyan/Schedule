//
//  ScheduleDatePickerViewViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import CoreGraphics

protocol DatePickerViewModel {
    var minDate: Dynamic<NSDate> { get }
}

class ScheduleCreatorDatePickerViewViewModel : BaseViewModel,BaseViewModelPresentation, DatePickerViewModel {
    
    var model: Dynamic<AnyObject?>
    var minDate: Dynamic<NSDate> = Dynamic(NSDate())
    var height: Dynamic<CGFloat> = Dynamic(216)
    
    init(model: AnyObject?) {
        self.model = Dynamic(model)
    }

}