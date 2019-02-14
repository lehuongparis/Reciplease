//
//  RecipData.swift
//  Reciplease
//
//  Created by AMIMOBILE on 13/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import CoreData

class RecipData: NSManagedObject {
    
    static var all: [RecipData] {
        let request: NSFetchRequest<RecipData> =  RecipData.fetchRequest()
        guard let recipsList = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipsList
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        RecipData.all.forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }
    
    static func deleteRecipSelected(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        
        for recip in RecipData.all {
            if recip.id == id {
                viewContext.delete(recip)
            }
            try? viewContext.save()
        }
    }
}
