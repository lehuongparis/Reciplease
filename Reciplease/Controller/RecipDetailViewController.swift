//
//  RecipDetailViewController.swift
//  Reciplease
//
//  Created by AMIMOBILE on 31/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import SafariServices

class RecipDetailViewController: UIViewController {
    
    private let recipService = RecipService()
    var recipDetailList = [RecipDetail]()
    var recipDetail: RecipDetail?
    var recip: Match?
    var recipsFavorite = [RecipEntity]()

    @IBOutlet weak var recipDetailTableView: UITableView!
    @IBOutlet weak var recipDetailImageView: GradientImageView!
    @IBOutlet weak var recipDetailNameLabel: UILabel!
    @IBOutlet weak var recipDetailRatingLabel: UILabel!
    @IBOutlet weak var recipDetailTimeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
        recipsFavorite = RecipEntity.fetchAll()
        setRightButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.update()
        recipsFavorite = RecipEntity.fetchAll()
        setRightButtonItem()
    }

    private func setRightButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        if RecipEntity.checkRecipSavedInData(id: recipDetail?.id ?? "") {
            navigationItem.rightBarButtonItem?.tintColor = .red
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .white
        }
    }
    
    @objc private func favoriteButtonTapped() {
        if RecipEntity.checkRecipSavedInData(id: recipDetail?.id ?? "") {
            deleteRecip()
        } else {
            saveRecip()
        }
    }
    
    private func deleteRecip() {
        RecipEntity.deleteRecipSelected(id: recipDetail?.id ?? "")
        recipsFavorite = RecipEntity.fetchAll()
        presentAlert(message: "Your recip has been deleted in the favorite")
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func saveRecip() {
        let recipData = RecipEntity(context: AppDelegate.viewContext)
        if let recip = recip, let recipDetail = recipDetail {
            recipData.id = recip.id
            recipData.name = recip.recipeName
            recipData.duration = recip.totalTimeInSeconds.timeInHoursandMinutes
            recipData.like = String(recip.rating)
            recipData.source = recipDetail.source.sourceRecipeUrl
            saveIngredientEntities(recip: recip, for: recipData)
            saveIngredientLineEntities(recipDetail: recipDetail, for: recipData)
            recipData.image = recip.smallImageUrls[0].stringImagetoDataImage
            recipData.imageDetail = recipDetail.images[0].hostedLargeUrl?.absoluteString.stringImagetoDataImage
            }
                do {
            try AppDelegate.viewContext.save()
            recipsFavorite = RecipEntity.fetchAll()
            presentAlert(message: "Your recip has been added in the favorite")
            navigationItem.rightBarButtonItem?.tintColor = .red
                } catch  {
            presentAlert(message: "Sorry, your recip can't added in the favorite")
        }
    }
    
    private func saveIngredientEntities (recip: Match, for RecipEntity: RecipEntity) {
        for ingredient in recip.ingredients {
            let ingredientEntity = IngredientEntity(context: AppDelegate.viewContext)
            ingredientEntity.name = ingredient
            ingredientEntity.recip = RecipEntity
        }
    }
    
    private func saveIngredientLineEntities(recipDetail: RecipDetail, for RecipEntity: RecipEntity) {
        for ingredientLine in recipDetail.ingredientLines {
            let ingredientLienEntities = IngredientLineEntity(context: AppDelegate.viewContext)
            ingredientLienEntities.name = ingredientLine
            ingredientLienEntities.recip = RecipEntity
        }
    }
    
    @IBAction func getDirectionButton() {
        if let urlString = recipDetailList[0].source.sourceRecipeUrl {
            directionSafari(for: urlString)
        } else {
            presentAlert(message: "Sorry, No source available")
        }
    }
    
    private func directionSafari(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    private func update() {
        recipDetail = recipDetailList[0]
        recipDetailNameLabel.text = recipDetailList[0].name
        recipDetailTimeLabel.text = recipDetailList[0].totalTimeInSeconds.timeInHoursandMinutes
        recipDetailRatingLabel.text = String(recipDetailList[0].rating) + "k"
        if let imageData = try? Data(contentsOf: recipDetailList[0].images[0].hostedLargeUrl!) {
            recipDetailImageView.image = UIImage(data: imageData)
        } else {
            recipDetailImageView.image = UIImage(named: "imagerecipdefault")
        }
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension RecipDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipDetailList[0].ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipDetailTableView.dequeueReusableCell(withIdentifier: "IngreDetailCell", for: indexPath)
        let ingredient = recipDetailList[0].ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredient.stringToFirstCapitalLetter
        return cell
    }
}
