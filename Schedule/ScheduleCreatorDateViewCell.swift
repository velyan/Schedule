//
//  ScheduleCreatorDateViewCell.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/7/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCreatorDateViewCell: UITableViewCell, BaseView {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    
    var viewModel: BaseViewModel? {
        didSet {
            configureBindings()
        }
    }
    
    func configureBindings() {
        let dateVM = viewModel as? ScheduleCreatorDateViewViewModel
        dateVM?.date.bindAndFire{ [unowned self] in
            self.dateValueLabel.text = $0
        }
        dateVM?.label.bindAndFire{ [unowned self] in
            self.dateLabel.text = $0
        }
    }
}
