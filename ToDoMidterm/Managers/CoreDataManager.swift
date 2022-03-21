//
//  CoreDataManager.swift
//  ToDoMidterm
//
//  Created by Quinn Brittain on 3/20/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()

    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
