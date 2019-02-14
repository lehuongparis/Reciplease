//
//  RecipDetailFavoriteViewController.swift
//  Reciplease
//
//  Created by AMIMOBILE on 13/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import SafariServices

class RecipDetailFavoriteViewController: UIViewController {
    
    var recipDetailFavoriteSelected: RecipData?
    
    @IBOutlet weak var recipDetailFavoriteTableView: UITableView!
    @IBOutlet weak var recipDetailFavoriteImageView: GradientImageView!
    @IBOutlet weak var recipDetailFavoriteNameLabel: UILabel!
    @IBOutlet weak var recipDetailFavoriteLikeLabel: UILabel!
    @IBOutlet weak var recipDetailFavoriteDurationLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "starfavorite"), style: .plain, target: self, action: #selector(updateFavovite))
    }
    
    private func update() {
        recipDetailFavoriteNameLabel.text = recipDetailFavoriteSelected?.name
        recipDetailFavoriteLikeLabel.text = recipDetailFavoriteSelected?.like
        recipDetailFavoriteDurationLabel.text = recipDetailFavoriteSelected?.duration
        if let imageData = recipDetailFavoriteSelected?.imageDetail?.stringImagetoDataImage, let image = UIImage(data: imageData) {
            recipDetailFavoriteImageView.image = image
        } else {
            let image = UIImage(named: "imagerecipdefault")
            recipDetailFavoriteImageView.image = image
        }
    }
    
    @objc private func updateFavovite() {
        guard let id = recipDetailFavoriteSelected?.id else {
            presentAlert(message: "Can't delete this recip in the Favorite")
            return
        }
            RecipData.deleteRecipSelected(id: id)
            presentAlert(message: "This recips has been deleted in the Favorite")
        
        }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func getDirectionButton() {
        let urlString = recipDetailFavoriteSelected?.source
        guard let url = URL(string: urlString ?? "") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}

extension RecipDetailFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipDetailFavoriteSelected?.ingredientLines?.stringToArrayString.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = recipDetailFavoriteTableView.dequeueReusableCell(withIdentifier: "IngresDetailFavoriteCell", for: indexPath)
        let ingredient = recipDetailFavoriteSelected?.ingredientLines?.components(separatedBy: ", ")[indexPath.row] ?? ""
        cell.textLabel?.text = ingredient.stringToFirstCapitalLetter
        return cell
    }
}
