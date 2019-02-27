//
//  Ingredients.swift
//  Reciplease
//
//  Created by AMIMOBILE on 18/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import CoreData


class IngredientEntity: NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientEntity] {
        let request: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        guard let ingredients = try? viewContext.fetch(request) else { return [] }
        return ingredients
    }
}

