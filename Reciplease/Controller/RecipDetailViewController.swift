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
    var recipFavorite = [RecipData]()


    @IBOutlet weak var recipDetailTableView: UITableView!
    @IBOutlet weak var recipDetailImageView: GradientImageView!
    @IBOutlet weak var recipDetailNameLabel: UILabel!
    @IBOutlet weak var recipDetailRatingLabel: UILabel!
    @IBOutlet weak var recipDetailTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(saveRecip))
        self.update()
        recipFavorite = RecipData.all
    }
    
    @objc private func saveRecip() {
        let recipData = RecipData(context: AppDelegate.viewContext)
        if let recip = recip, let recipDetail = recipDetail {
            recipData.id = recip.id
            recipData.name = recip.recipeName
            recipData.ingredients = recip.ingredients.joined(separator: ", ")
            recipData.like = String(recip.rating)
            recipData.duration = recip.totalTimeInSeconds.timeInHoursandMinutes
            recipData.image = recip.smallImageUrls[0]
            recipData.source = recipDetail.source.sourceRecipeUrl
            recipData.ingredientLines = recipDetail.ingredientLines.joined(separator: ", ")
            recipData.imageDetail = recipDetail.images[0].hostedLargeUrl?.absoluteString
        }
        
        do {
            try AppDelegate.viewContext.save()
            presentAlert(message: "Your recip has been added in the favorite")
        } catch  {
            presentAlert(message: "Sorry, your recip can't added in the favorite")
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
