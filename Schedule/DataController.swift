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
    
    fileprivate(set) var managedObjectContext: NSManagedObjectContext?
    
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
    
    func fetch(_ entityName: String, sortDescriptors: Array<NSSortDescriptor>) -> Array<NSManagedObject>? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        var result : Array<NSManagedObject>?
        do {
            result = try managedObjectContext!.fetch(fetchRequest) as? Array<NSManagedObject>
        } catch {
            fatalError("Failed to fetch \(entityName): \(error)")
        }
        return result
    }
    
    fileprivate func createStack() {
        guard let modelURL = Bundle.main.url(forResource: kManagedObjectModel, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext?.persistentStoreCoordinator = psc
    }
    
    fileprivate func configurePersistentStore() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        let storeURL = docURL.appendingPathComponent(kManagedObjectModel)
        do {
            try managedObjectContext!.persistentStoreCoordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}
