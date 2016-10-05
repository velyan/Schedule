//
//  ScheduleCreatorDatePickerCell.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/7/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCreatorDatePickerCell: UITableViewCell, BaseView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerValueChanged(_ sender: AnyObject) {
        self.date.value = (sender as! UIDatePicker).date
    }
    var date: Dynamic<Date?> = Dynamic(nil)
    
    var viewModel: BaseViewModel? {
        didSet {
            configureBindings()
        }
    }
    
    func configureBindings() {
        if let pickerVM = viewModel as? ScheduleCreatorDatePickerViewViewModel {
            pickerVM.minDate.bindAndFire{ [unowned self] in
                self.datePicker.minimumDate = $0 as Date
            }
            pickerVM.model.bindAndFire { [unowned self] in
                if let date = $0 as? Date {
                    self.datePicker.date = date
                }
            }
            date.bind { [unowned self] in
                self.viewModel?.model.value = $0 as AnyObject
            }
        }
    }
}
