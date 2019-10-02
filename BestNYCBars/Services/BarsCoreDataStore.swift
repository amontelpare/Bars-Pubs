//
//  BarsCoreDataStore.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import CoreData

class BarsCoreDataStore: ListBarsStoreProtocol {

    // MARK: - Managed object contexts
    
    var mainManagedObjectContext: NSManagedObjectContext
    var privateManagedObjectContext: NSManagedObjectContext
    
    // MARK: - Object lifecycle
    
    init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = Bundle.main.url(forResource: "BestNYCBars", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        /* The directory the application uses to store the Core Data store file.
         This code uses a file named "DataModel.sqlite" in the application's documents directory.
         */
        let storeURL = docURL.appendingPathComponent("BestNYCBars.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        
        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedObjectContext.parent = mainManagedObjectContext
    }
    
    deinit {
        do {
            try self.mainManagedObjectContext.save()
        } catch {
            fatalError("Error deinitializing main managed object context")
        }
    }
    
    // MARK: - CRUD operations - Inner closure
    
    func fetchBars(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsResponse) -> Void) {
        privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedBar")
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedBar]
                let bars = results.map { ["restaurant" : $0.toBar()] }
                completionHandler { return SearchBarsResponse(resultsFound: 0, resultsStart: startAt, resultsShown: count, barsArrayOfDictionaries: bars) }
            } catch {
                completionHandler { throw ListBarsStoreError.CannotFetch("Can not fetch bars") }
            }
        }
    }
}
