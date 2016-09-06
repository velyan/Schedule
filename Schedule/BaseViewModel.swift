//
//  ViewModel.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/6/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

protocol BaseViewModel {
    var model : AnyObject? { get }
    static func new(model: AnyObject?) -> BaseViewModel
}