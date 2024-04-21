//
//  CoreDataService.swift
//  Navigation
//
//  Created by Руслан Усманов on 10.03.2024.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var context: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
    func saveContext()
}

class CoreDataService: CoreDataServiceProtocol  {
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .name)
        container.loadPersistentStores(completionHandler: {description, error in
            if let error = error {
                print(error.localizedDescription)
                assertionFailure()
            }
        })
        return container
    }()
    
    private(set) lazy var context: NSManagedObjectContext = {
        container.viewContext
    }()
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = container.persistentStoreCoordinator
        return context
    }()
    
    func saveContext(){
        do {
            try context.save()
        } catch {
            print("Save error")
        }
    }
    
    
    
}

     private extension String {
         static let name = "Model"
     }

