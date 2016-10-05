
//  ScheduleCreatorViewController.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import UIKit

let kScheduleCreatorDateViewCellIdentifier = "ScheduleCreatorDateViewCell"
let kScheduleCreatorDatePickerCellIdentifier = "ScheduleCreatorDatePickerCell"

class ScheduleCreatorViewController: UIViewController, BaseView, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel : BaseViewModel?
    @IBOutlet weak var tableView: UITableView!
    @IBAction func didClear(_ sender: AnyObject) {
        (viewModel as? ScheduleCreatorViewViewModel)?.reset()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (viewModel as? ScheduleCreatorViewViewModel)?.save()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModels = (viewModel as? BaseViewModelHierarchy)?.children {
            return viewModels.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ((indexPath as NSIndexPath).item == 1) ? kScheduleCreatorDatePickerCellIdentifier : kScheduleCreatorDateViewCellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier   , for: indexPath)
        var view = cell as! BaseView
        view.viewModel = (viewModel as? ScheduleCreatorViewViewModel)?.children[(indexPath as NSIndexPath).item]
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewVM = (viewModel as? ScheduleCreatorViewViewModel)
        let cellVM = viewVM?.children[(indexPath as NSIndexPath).item] as! BaseViewModelPresentation
        return cellVM.height.value
    }
}
