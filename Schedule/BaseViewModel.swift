//
//  ViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import CoreGraphics
import UIKit

protocol BaseViewModelContract {
    var model: Dynamic<AnyObject?> { get set }
}

protocol BaseViewModelPresentation {
    var height: Dynamic<CGFloat> { get }
}

protocol BaseViewModelHierarchy {
    var children: Array<BaseViewModel> { get }
}

class BaseViewModel: BaseViewModelContract, BaseViewModelHierarchy, BaseViewModelPresentation {
    
    lazy var dataController : DataController = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.dataController
    }()
    lazy var dateTransformer: DateTransformer = { return DateTransformer() }()

    
    var model: Dynamic<AnyObject?>
    var children: Array<BaseViewModel> = Array<BaseViewModel>()
    var height: Dynamic<CGFloat> = Dynamic(0)

    init(model: AnyObject?) {
        self.model = Dynamic(model)
    }
}
