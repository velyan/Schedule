
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
    @IBAction func didClear(sender: AnyObject) {
        (viewModel as? ScheduleCreatorViewViewModel)?.reset()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        (viewModel as? ScheduleCreatorViewViewModel)?.save()
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModels = (viewModel as? BaseViewModelHierarchy)?.children {
            return viewModels.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = (indexPath.item == 1) ? kScheduleCreatorDatePickerCellIdentifier : kScheduleCreatorDateViewCellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier   , forIndexPath: indexPath)
        var view = cell as! BaseView
        view.viewModel = (viewModel as? ScheduleCreatorViewViewModel)?.children[indexPath.item]
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let viewVM = (viewModel as? ScheduleCreatorViewViewModel)
        let cellVM = viewVM?.children[indexPath.item] as! BaseViewModelPresentation
        return cellVM.height.value
    }
}