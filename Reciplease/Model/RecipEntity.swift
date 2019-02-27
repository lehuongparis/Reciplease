//
//  Recips.swift
//  Reciplease
//
//  Created by AMIMOBILE on 17/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import CoreData

class RecipEntity: NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipEntity] {
        let request: NSFetchRequest<RecipEntity> =  RecipEntity.fetchRequest()
        guard let recipsList = try? viewContext.fetch(request) else { return [] }
        return recipsList
    }

    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: RecipEntity.fetchRequest())
        let _ = try? viewContext.execute(deleteRequest)
        try? viewContext.save()
    }
    
    static func deleteRecipSelected(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipEntity> = RecipEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipsList = try? viewContext.fetch(request) else { return }
        guard let recipWillBeDeleted = recipsList.first else { return }
        viewContext.delete(recipWillBeDeleted)
        try? viewContext.save()
    }
    
    // Check recip already saved in Data
    static func checkRecipSavedInData(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
        let request: NSFetchRequest<RecipEntity> = RecipEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipsList = try? viewContext.fetch(request) else { return false }
        if recipsList.isEmpty { return false }
        return true
    }
    
    // get recip with an Id
    static func getRecipselectedInData(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipEntity] {
        let request: NSFetchRequest<RecipEntity> = RecipEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipSelected = try? viewContext.fetch(request) else { return [] }
        return recipSelected
    }


}
