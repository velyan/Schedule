//
//  OverviewDetailViewCell.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/8/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation
import UIKit

class OverviewDetailViewCell: UITableViewCell, BaseView {
    
    @IBOutlet weak var beginLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    var viewModel: BaseViewModel? {
        didSet {
            configureBindings()
        }
    }
    
    func configureBindings() {
        if let overviewVM = self.viewModel as? OverviewDetailViewViewModel {
            overviewVM.beginLabel?.bindAndFire { [unowned self] in
                self.beginLabel.text = $0
            }
            overviewVM.beginDateLabel?.bindAndFire { [unowned self] in
                self.beginDateLabel.text = $0
            }
            overviewVM.endLabel?.bindAndFire { [unowned self] in
                self.endLabel.text = $0
            }
            overviewVM.endDateLabel?.bindAndFire { [unowned self] in
                self.endDateLabel.text = $0
            }
        }
    }
}