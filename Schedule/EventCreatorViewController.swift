
//  EventCreatorViewController.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import UIKit

class EventCreatorViewController: UIViewController {
    
    var viewModel : EventCreatorViewViewModel?
    var selectedDate : Dynamic<NSDate>?
    
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func pickerDidChangeValue(sender: UIDatePicker) {
        self.selectedDate?.value = sender.date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = Dynamic(datePicker.date)
        configureBindings()

    }

    func configureBindings() {
        viewModel?.beginDate.bindAndFire { [unowned self] in
            self.beginDateLabel.text = $0
        }
        
        viewModel?.minBeginDate.bindAndFire { [unowned self] in
            self.datePicker.minimumDate = $0
        }
        
        viewModel?.beginDateLabel.bindAndFire{ [unowned self] in
            self.beginDateLabel.text = $0
        }
        
        //MARK: Danger!
        viewModel?.date.bindAndFire{ [unowned self] in
            if let value = $0 {
                self.datePicker.date = value
            }
        }
        
        selectedDate?.bind { [unowned self] in
            self.viewModel?.date.value = $0
        }
    }

}