//
//  Dynamic.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/4/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

class Dynamic<T> {
    typealias Listener = T -> Void
    var listeners: Array<Listener> = Array<Listener>()
    
    func bind(listener: Listener?) {
        if let _ = listener {
            listeners.append(listener!)
        }
    }
    
    func bindAndFire(listener: Listener?) {
        bind(listener)
        fire(value)
    }
    
    var value: T {
        didSet {
            fire(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func fire(value: T){
        for listener in listeners {
            listener(value)
        }
    }
    
}