//
//  ViewController.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import UIKit

let kOverviewDetailViewCellIdentifier = "OverviewDetailViewCell"
let kScheduleEditorPushSegueIdentifier = "ScheduleEditorPushSegue"

class OverviewViewController: UIViewController, BaseView, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    var viewModel: BaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (self.viewModel as? OverviewViewViewModel)?.reload()
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let destinationVC = segue.destinationViewController as? ScheduleCreatorViewController {
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            destinationVC.viewModel = (viewModel as? OverviewViewViewModel)?.viewModelToPresent(selectedIndex)
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModels = (viewModel as? BaseViewModelHierarchy)?.children {
            return viewModels.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kOverviewDetailViewCellIdentifier, forIndexPath: indexPath)
        var view = cell as! BaseView
        view.viewModel = (viewModel as? BaseViewModelHierarchy)?.children[indexPath.item]
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let viewVM = (viewModel as? BaseViewModelHierarchy)
        let cellVM = viewVM?.children[indexPath.item] as! BaseViewModelPresentation
        return cellVM.height.value
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(kScheduleEditorPushSegueIdentifier, sender: self)
    }
}

