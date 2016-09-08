//
//  ViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import CoreGraphics

protocol BaseViewModel {
    var model: Dynamic<AnyObject?> { get set }
}

protocol BaseViewModelPresentation {
    var height: Dynamic<CGFloat> { get }
}

protocol BaseViewModelHierarchy {
    var children: Array<BaseViewModel> { get }
}