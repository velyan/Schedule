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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.viewModel as? OverviewViewViewModel)?.reload()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destinationVC = segue.destination as? ScheduleCreatorViewController {
            let selectedIndex = (tableView.indexPathForSelectedRow as NSIndexPath?)?.item
            destinationVC.viewModel = (viewModel as? OverviewViewViewModel)?.scheduleCreatorViewModelAtIndex(selectedIndex)
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModels = (viewModel as? BaseViewModelHierarchy)?.children {
            return viewModels.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kOverviewDetailViewCellIdentifier, for: indexPath)
        var view = cell as! BaseView
        view.viewModel = (viewModel as? BaseViewModelHierarchy)?.children[(indexPath as NSIndexPath).item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            (viewModel as? OverviewViewViewModel)?.deleteViewModelAtIndex((indexPath as NSIndexPath).item)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewVM = (viewModel as? BaseViewModelHierarchy)
        let cellVM = viewVM?.children[(indexPath as NSIndexPath).item] as! BaseViewModelPresentation
        return cellVM.height.value
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: kScheduleEditorPushSegueIdentifier, sender: self)
    }


}

