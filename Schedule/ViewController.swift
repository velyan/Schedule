//
//  ViewController.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/3/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var defaultModel : ScheduleModel = {
        let model = ScheduleModel(beginDate: NSDate())
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegueWithIdentifier("presentEventController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let destinationVC = navigationController.topViewController as? ScheduleCreatorViewController {
                destinationVC.viewModel = newViewModel(defaultModel) as? SchduleCreatorViewViewModel
            }
        }
    }
    
    func newViewModel(model: AnyObject) -> AnyObject {
        let viewModel = SchduleCreatorViewViewModel(model: defaultModel)
        return viewModel
    }
}

