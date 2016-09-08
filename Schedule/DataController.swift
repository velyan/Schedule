//
//  DataController.swift
//  Schedule
//
//  Created by Velislava Yanchina on 9/8/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import UIKit
import CoreData

let kManagedObjectModel = "Schedule"

class DataController {
    
    private(set) var managedObjectContext: NSManagedObjectContext?
    
    init() {
        createStack()
        configurePersistentStore()
    }
    
    func save() {
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func fetch(entityName: String, sortDescriptors: Array<NSSortDescriptor>) -> Array<NSManagedObject>? {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        var result : Array<NSManagedObject>?
        do {
            result = try managedObjectContext!.executeFetchRequest(fetchRequest) as? Array<NSManagedObject>
        } catch {
            fatalError("Failed to fetch \(entityName): \(error)")
        }
        return result
    }
    
    private func createStack() {
        guard let modelURL = NSBundle.mainBundle().URLForResource(kManagedObjectModel, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext?.persistentStoreCoordinator = psc
    }
    
    private func configurePersistentStore() {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex-1]
        let storeURL = docURL.URLByAppendingPathComponent(kManagedObjectModel)
        do {
            try managedObjectContext!.persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}