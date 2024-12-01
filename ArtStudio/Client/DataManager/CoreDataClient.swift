//
//  CoreDataClient.swift
//  ArtStudio
//
//  Created by stone on 2024/12/1.
//

import Foundation
import CoreData
import ComposableArchitecture

protocol CoreDataClientProtocol {
    func loadFetchedTopicDate() -> Date?
    func updateFetchedTopicDate(to newDate: Date)
}

struct CoreDataClient: CoreDataClientProtocol {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func loadFetchedTopicDate() -> Date? {
        let context = container.viewContext
        let request = NSFetchRequest<LocalSetting>(entityName: "LocalSetting")
        request.fetchLimit = 1

        do {
            let results = try context.fetch(request)
            return results.first?.fetchTopicDate
        } catch {
            return nil
        }
    }
        
    func updateFetchedTopicDate(to newDate: Date) {
        let context = container.viewContext
        let request = NSFetchRequest<LocalSetting>(entityName: "LocalSetting")
        request.fetchLimit = 1

        do {
            let results = try context.fetch(request)

            if let fetchedDateEntity = results.first {
                fetchedDateEntity.fetchTopicDate = newDate
            } else {
                let newFetchedDateEntity = LocalSetting(context: context)
                newFetchedDateEntity.fetchTopicDate = newDate
            }

            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("Error updating fetched topic date: \(error.localizedDescription)")
        }
        
    }
}

extension DependencyValues {
    var coreDataClient: CoreDataClientProtocol {
        get { self[CoreDataClientKey.self] }
        set { self[CoreDataClientKey.self] = newValue }
    }
    
    private enum CoreDataClientKey: DependencyKey {
        static let liveValue: CoreDataClientProtocol = CoreDataClient(
            container: {
                let container = NSPersistentContainer(name: "ArtStudio")
                container.loadPersistentStores { _, error in
                    if let error = error {
                        fatalError("Failed to load Core Data store: \(error)")
                    }
                }
                return container
            }()
        )
    }
}
