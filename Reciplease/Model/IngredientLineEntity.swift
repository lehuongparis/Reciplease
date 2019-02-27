//
//  IngredientLines.swift
//  Reciplease
//
//  Created by AMIMOBILE on 18/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import CoreData

class IngredientLineEntity: NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientLineEntity] {
        let request: NSFetchRequest<IngredientLineEntity> = IngredientLineEntity.fetchRequest()
        guard let ingredientLines = try? viewContext.fetch(request) else { return [] }
        return ingredientLines
    }
}
