//
//  CoredataWithMockContainerTests.swift
//  RecipleaseTests
//
//  Created by AMIMOBILE on 21/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease


class CoredataWithMockContainerTests: XCTestCase {

    // MARK: - Preperties
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    // MARK: Tests Life Cycle
    override func tearDown() {
        RecipEntity.deleteAll(viewContext: mockContainer.viewContext)
        super.tearDown()
    }

    // MARK: - Tests Methods
    private func saveRecipFavorite1(into managedObjectContext: NSManagedObjectContext) {
        let recipFavorite1 = RecipEntity(context: managedObjectContext)
        recipFavorite1.id = "Perfect-Homemade-Alfredo-Sauce-2643296"
        recipFavorite1.name = "Perfect Homemade Alfredo Sauce"
        recipFavorite1.like = "200K"
        recipFavorite1.duration = "0h45"
        recipFavorite1.source = "https://www.chef-in-training.com/perfect-homemade-alfredo-sauce/"
        recipFavorite1.image = "sauce".stringImagetoDataImage
        recipFavorite1.imageDetail = "sauceDetail".stringImagetoDataImage
        saveIngredients(into: managedObjectContext, for: recipFavorite1)
        saveIngredientLines(into: managedObjectContext, for: recipFavorite1)
    }
    
    private func saveRecipFavorite2(into managedObjectContext: NSManagedObjectContext) {
        let recipFavorite2 = RecipEntity(context: managedObjectContext)
        recipFavorite2.id = "Slow-Cooker-Crack-Chicken-2639145"
        recipFavorite2.name = "Slow Cooker Crack Chicken"
        recipFavorite2.like = "400K"
        recipFavorite2.duration = "1h45"
        recipFavorite2.source = "https://fitmomjourney.com/slow-cooker-crack-chicken"
        recipFavorite2.image = "chicken".stringImagetoDataImage
        recipFavorite2.imageDetail = "chickenDetail".stringImagetoDataImage
        saveIngredients(into: managedObjectContext, for: recipFavorite2)
        saveIngredientLines(into: managedObjectContext, for: recipFavorite2)

    }
 
    private func saveIngredients(into managedObjectContext: NSManagedObjectContext, for RecipEntity: RecipEntity) {
        let ingredients =  ["Lemon", "Curry", "Salad"]
        for ingredient in ingredients {
            let ingredientEntity = IngredientEntity(context: managedObjectContext)
            ingredientEntity.name = ingredient
            ingredientEntity.recip = RecipEntity
        }
    }
    
    private func saveIngredientLines(into managedObjectContext: NSManagedObjectContext, for RecipEntity: RecipEntity) {
        let ingredientLines = ["1/2Kg Sugar", "1 Lemon", "1/2 Apple"]
        for ingredientLine in ingredientLines {
            let ingredientLineEntity = IngredientLineEntity(context: managedObjectContext)
            ingredientLineEntity.name = ingredientLine
            ingredientLineEntity.recip = RecipEntity
        }
    }
    
    
    // MARK= - Unit Tests
    func testSaveRecipInPersistentContainer() {
        saveRecipFavorite1(into: mockContainer.newBackgroundContext())
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    func testDeleteAllRecipsInPersistentContainer() {
        saveRecipFavorite1(into: mockContainer.viewContext)
        saveRecipFavorite2(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        RecipEntity.deleteAll(viewContext: mockContainer.viewContext)
        XCTAssertEqual(RecipEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    func testDelete1RecipInPersistentContainer() {
        saveRecipFavorite1(into: mockContainer.viewContext)
        saveRecipFavorite2(into: mockContainer.viewContext)
        RecipEntity.deleteRecipSelected(id: "Slow-Cooker-Crack-Chicken-2639145", viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(RecipEntity.fetchAll(viewContext: mockContainer.viewContext).count, 1)
    }
    
    func testCheckRecipSavedInData() {
        saveRecipFavorite1(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(RecipEntity.checkRecipSavedInData(id: "Perfect-Homemade-Alfredo-Sauce-2643296", viewContext: mockContainer.viewContext))
    }
    
    func testFetchAllIngredients() {
        let recipFavorite1 = RecipEntity(context: mockContainer.viewContext)
        saveIngredients(into: mockContainer.viewContext, for: recipFavorite1)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(IngredientEntity.fetchAll(viewContext: mockContainer.viewContext).count, 3)
    }

    func testFetchAllIngredientLines() {
        let recipFavorite1 = RecipEntity(context: mockContainer.viewContext)
        saveIngredientLines(into: mockContainer.viewContext, for: recipFavorite1)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(IngredientLineEntity.fetchAll(viewContext: mockContainer.viewContext).count, 3)
    }
    
    func testGetRecipSelectedInData() {
        saveRecipFavorite1(into: mockContainer.viewContext)
        saveRecipFavorite2(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(RecipEntity.getRecipselectedInData(id: "Perfect-Homemade-Alfredo-Sauce-2643296", viewContext: mockContainer.viewContext).first?.id, "Perfect-Homemade-Alfredo-Sauce-2643296")
    }
}
